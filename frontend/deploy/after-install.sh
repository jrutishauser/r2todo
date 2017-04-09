#!/bin/bash

# build project

cd /var/www/html/

rm -rf node_modules

npm update
npm install
npm run build

# run tests

CI=true npm test
