#!/bin/bash
OLDIFS=$IFS

SOURCE_AIRPORT="DSM"
DEPT_DATE="2015-03-17"
RET_DATE="2015-03-24"

IFS=","
mkdir -p requests/$SOURCE_AIRPORT-$DEPT_DATE
while read f1 f2 f3 f4
do
    echo '{"request": {"slice": [{"origin": "'$SOURCE_AIRPORT'", "destination": "'$f3'", "date": "'$DEPT_DATE'"},{"origin": "'$f3'", "destination": "'$SOURCE_AIRPORT'", "date": "'$RET_DATE'"}],"passengers": {"adultCount": 1}, "solutions": 1, "refundable": false }}' > "requests/$SOURCE_AIRPORT-$DEPT_DATE/request-$f3-$DEPT_DATE.json"
done < airports.csv

IFS=$OLDIFS
