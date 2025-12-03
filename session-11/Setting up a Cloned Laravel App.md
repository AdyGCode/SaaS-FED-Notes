clone repository
cd into the new folder
touch database/database.sqlite
cp .env.dev .env
composer global update
composer install
composer update --dry-run
composer update
npm ci  // clean install
npm audit fix
artisan key:generate
artisan migrate:fresh --seed

Edit the .env file
change the 
- APP_NAME to "INSERT_NAME_OF_APP_HERE"
- APP_URL to the correct location (default to http://localhost:8000)
- APP_ENV to local (production when deployed to final site)
- APP_DEBUG to true (false when deployed to production)
- APP_LOCALE to en_AU (English Australian)
- LOG_LEVEL to debug (production set to errors)
- DB_CONNECTION to sqlite for development 
	- set to mysql, postgres etc when deployed
	- other DB settings depend on this connection type
- MAIL_MAILER to smtp
- MAIL_HOST to 127.0.0.1 (may be a 3rd party server)
- MAIL_PORT 2525
- MAIL_FROM_ADDRESS no-reply@example.com (depend on 3rd party, and domain name)

once all settings done and saved
you should be able to run the application in dev mode

composer run dev
Remember that Ady's Blade Kit template has dev-win and dev-linux for those operating systems.
composer run dev-win
