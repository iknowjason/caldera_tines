#!/bin/bash

# Fill in your Caldera server
#export CALDERA_SERVER=""

# Fill in your Caldera api key
#export CALDERA_API=""

# Test the abilities API endpoint
echo "[+] Test the abilities endpoint"
curl -k http://$CALDERA_SERVER:8888/api/v2/abilities   -H 'accept: application/json' -H "KEY:$CALDERA_API" | jq -r

# use jq to parse all technique_name and ability_id
echo "[+] List out all abilities and technique_names"
curl -k http://$CALDERA_SERVER:8888/api/v2/abilities   -H 'accept: application/json' -H "KEY:$CALDERA_API" | jq -r '.[] | {technique_name, ability_id}'

# Get the Paw Id for Windows agent
export PAW_ID=`curl -k http://$CALDERA_SERVER:8888/api/v2/agents \
  -H 'accept: application/json' -H "KEY:$CALDERA_API" | jq -r '.[].paw'`
echo "Paw ID for Windows host: $PAW_ID"

# Set the ability ID #1 for Download of Macro-Enabled Phishing Attachment
export ABILITY_1="1afaec09315ab71fdfb167175e8a019a"

# Execute Ability #1
curl -k http://$CALDERA_SERVER:8888/plugin/access/exploit \
  -H 'accept: application/json' -H "KEY:$CALDERA_API" -H POST \
  -d "{\"paw\":\"$PAW_ID\",\"ability_id\":\"$ABILITY_1\",\"obfuscator\":\"plain-text\"}"

# Set the ability Id #2 for share enumeration - net use
export ABILITY_2="42473624-a7fb-441a-ba9d-6cd1c683829c"

# Execute Ability #2
curl -k http://$CALDERA_SERVER:8888/plugin/access/exploit \
  -H 'accept: application/json' -H "KEY:$CALDERA_API" -H POST \
  -d "{\"paw\":\"$PAW_ID\",\"ability_id\":\"$ABILITY_2\",\"obfuscator\":\"plain-text\"}"

# Set the ability Id #3 for net localgroup
export ABILITY_3="5b25ae2e-b2db-4186-bb94-ddac2ef4fd70"

# Execute Ability #3
curl -k http://$CALDERA_SERVER:8888/plugin/access/exploit \
  -H 'accept: application/json' -H "KEY:$CALDERA_API" -H POST \
  -d "{\"paw\":\"$PAW_ID\",\"ability_id\":\"$ABILITY_3\",\"obfuscator\":\"plain-text\"}"

# Set the ability Id #4 for account discovery - net user
export ABILITY_4="5251e73e-a251-4386-a050-fa97f56ee1b9"

# Execute Ability #4
curl -k http://$CALDERA_SERVER:8888/plugin/access/exploit \
  -H 'accept: application/json' -H "KEY:$CALDERA_API" -H POST \
  -d "{\"paw\":\"$PAW_ID\",\"ability_id\":\"$ABILITY_4\",\"obfuscator\":\"plain-text\"}"
