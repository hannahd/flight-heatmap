#!/bin/bash
#Price Data from https://developers.google.com/qpx-express

echo "Departure Date, Return Date, Origin, Destination, Carrier, Price, Connections, Total Flight Time" > output-$SOURCE_AIRPORT-$DEPT_DATE.csv

FILES="responses/$SOURCE_AIRPORT-$DEPT_DATE/*.json"
for f in $FILES
do
    echo "Fetching $f..."
  DESTINATION_AIRPORT=`echo $f | cut -c35-37`
  cat $f | jsawk 'return "'$DEPT_DATE','$RET_DATE','$SOURCE_AIRPORT','$DESTINATION_AIRPORT',\"" +this.trips.data.carrier[0].name + "\"," + this.trips.tripOption[0].saleTotal.substring(3) + "," +(this.trips.data.airport.length - 2)+ "," + this.trips.tripOption[0].slice[0].duration' >>  output-$SOURCE_AIRPORT-$DEPT_DATE.csv
done


