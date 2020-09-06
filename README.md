# README

Rails based API that accepts an IP address and returns the geolocation for that IP.

Example request:
```
curl -X POST {URL}/api/geolocation -H 'Content-Type: application/json' -H 'Authorization: {AUTH_TOKEN}' -H 'Accept: application/json' -d '{ "ip": "219.8.8.8" }'
```

Example response:
```
{"data":{"id":"1a76","type":"location","attributes":{"country":"Japan","abbreviation":"JP","region":"Tokyo","city":"Tokyo"}}}
```

Elasticsearch (version 7.8.1) is used to ensure performant IP address lookups.
FastJsonapi is used to decrease data response time as well as comply with the JSON:API spec.

IP2Location's lite CSV file is the provider of the IP to geolocation data: https://lite.ip2location.com/database/ip-country-region-city The free CSV file provided is updated monthly.
A sidekiq batch job parses the CSV file. Once that is completed a callback triggers the job to import the data into elasticsearch.
