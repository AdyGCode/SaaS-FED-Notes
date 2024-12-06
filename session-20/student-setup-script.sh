#!/bin/bash

echo "Starting Laravel application setup..."

# Flag to track if any step fails
SETUP_FAILED=0
COMPOSER_INSTALL_FAILED=0
FAIL_STEP=""

# Step 1: Clean up existing node_modules and vendor directories
echo "Removing existing node_modules and vendor directories..."
rm -rf node_modules vendor

# Step 2: Remove existing SQLite database
if [ -f "database/database.sqlite" ]; then
    echo "Removing existing database/database.sqlite"
    rm database/database.sqlite
fi

# Step 3: Set up environment file
if [ -f ".env.dev" ]; then
    echo "Copying .env.dev to .env"
    if ! cp .env.dev .env; then
        echo "Failed to copy .env.dev"
        exit 1
    fi
fi

# Step 4: Configure database settings
if [ -f ".env" ]; then
    echo "Modifying .env file for database configuration"
    # Get current directory name for database name
    DB_NAME=$(basename "$PWD")
    
    # Replace DB_CONNECTION
    sed -i 's/DB_CONNECTION=sqlite/DB_CONNECTION=mysql/' .env
    
    # Uncomment and set MySQL connection details
    sed -i 's/# DB_HOST=127.0.0.1/DB_HOST=127.0.0.1/' .env
    sed -i 's/# DB_PORT=3306/DB_PORT=3306/' .env
    sed -i "s/# DB_DATABASE=laravel/DB_DATABASE=$DB_NAME/" .env
    sed -i 's/# DB_USERNAME=root/DB_USERNAME=root/' .env
    sed -i 's/# DB_PASSWORD=/DB_PASSWORD=/' .env
fi

# Step 5: Create database
if [ -f ".env" ]; then
    if [ ! -z "$DB_NAME" ]; then
        echo "Creating database: $DB_NAME"
        if ! mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`"; then
            echo "Failed to create database $DB_NAME"
            exit 1
        fi
    fi
fi

# Step 6: Run Composer
if [ -f "composer.json" ]; then
    echo "Running composer install"
    if ! composer install --ignore-platform-req=ext-http; then
        echo "Composer install failed, attempting composer update..."
        COMPOSER_INSTALL_FAILED=1
    fi
fi

if [ $COMPOSER_INSTALL_FAILED -eq 1 ]; then
    if ! composer update --ignore-platform-req=ext-http; then
        echo "Composer update also failed"
        exit 1
    fi
    echo "Composer update succeeded - continuing with installation"
fi

# Step 7: Run NPM
if [ -f "package.json" ]; then
    echo "Installing NPM dependencies"
    if ! npm install; then
        echo "NPM install failed"
        exit 1
    fi
    
    echo "Running NPM build"
    if ! npm run build; then
        echo "NPM build failed"
        exit 1
    fi
fi

# Step 8: Run Laravel migrations and seeding
echo "Running Laravel migrations and seeding"
if ! php artisan migrate:fresh --seed; then
    echo "Migrations or seeding failed"
    exit 1
fi

# Step 9: Start queue listener
echo "Starting queue listener"
php artisan queue:listen &

echo "Setup completed successfully!"