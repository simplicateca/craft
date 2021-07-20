# Restart PHP-FPM on CloudWays via API
# Replace YOUR_NAME%40DOMAIN.COM with your email (URL-encoded), YOUR_API_KEY with your Cloudways API key and SERVER_ID with id of your server

# If you want to use it with DeployBot just add the following commands to the "Run commands after new version becomes active" section.

# Do auth and receive access_token
cloudways_token=$(curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'email=YOUR_NAME%40DOMAIN.COM&api_key=API_KEY' 'https://api.cloudways.com/api/v1/oauth/access_token' | python3 -c "import sys, json; print(json.load(sys.stdin)['access_token'])")

# Restart PHP-FPM
curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' --header "Authorization: Bearer ${cloudways_token}" -d 'server_id=SERVER_ID&service=php7.4-fpm&state=restart' 'https://api.cloudways.com/api/v1/service/state'