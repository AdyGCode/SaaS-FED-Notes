#!/usr/bin/env bash

echo "Running pnpm install..."
output=$(pnpm install 2>&1)
status=$?

echo "$output"

if [ $status -ne 0 ]; then
  if echo "$output" | grep -q "approve-builds"; then
    echo "Detected approve-builds requirement. Running it..."
    pnpm approve-builds && pnpm install
    exit $?
  else
    echo "pnpm install failed for another reason."
    exit $status
  fi
fi

echo "pnpm install completed successfully."
