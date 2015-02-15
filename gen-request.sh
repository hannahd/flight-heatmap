#!/bin/bash
OLDIFS=$IFS

SOURCE_AIRPORT="DSM"
DEPT_DATE="2015-03-17"
RET_DATE="2015-03-24"

IFS=","
mkdir -p requests/$SOURCE_AIRPORT-$DEPT_DATE

FILE=airports.geo.json

  NUM_AIRPORTS=`cat $FILE | jsawk 'return this.features.length'`
  for ((i = 0 ; i < $NUM_AIRPORTS ; i++ ));
  do
     cmd="return this.features[$i].properties.airport_code"
     DESTINATION=`cat $FILE | jsawk $cmd`
     echo "..................$DESTINATION"
     echo '{"request": {"slice": [{"origin": "'$SOURCE_AIRPORT'", "destination": "'$DESTINATION'", "date": "'$DEPT_DATE'"},{"origin": "'$DESTINATION'", "destination": "'$SOURCE_AIRPORT'", "date": "'$RET_DATE'"}],"passengers": {"adultCount": 1}, "solutions": 1, "refundable": false }}' > "requests/$SOURCE_AIRPORT-$DEPT_DATE/request-$DESTINATION-$DEPT_DATE.json"
  done

IFS=$OLDIFS
