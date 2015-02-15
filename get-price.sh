#!/bin/bash
#Price Data from https://developers.google.com/qpx-express

source API_KEY.sh #ADD YOUR OWN API KEY AS $API_KEY

SOURCE_AIRPORT="DSM"
DEPT_DATE="2015-03-17"
RET_DATE="2015-03-24"

mkdir -p responses/$SOURCE_AIRPORT-$DEPT_DATE
mkdir -p completed-requests/$SOURCE_AIRPORT-$DEPT_DATE


FILES="requests/$SOURCE_AIRPORT-$DEPT_DATE/*.json"
for f in $FILES
do
  AIRPORT_CODE=`echo $f | cut -c33-35`
  echo "Fetching $f..."
  # take action on each file. $f store current file name
  curl -d @$f --header "Content-Type: application/json" https://www.googleapis.com/qpxExpress/v1/trips/search\?key\=$API_KEY > responses/$SOURCE_AIRPORT-$DEPT_DATE/response_$AIRPORT_CODE.json
  mv $f completed-requests/$SOURCE_AIRPORT-$DEPT_DATE
done
