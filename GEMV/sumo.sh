#!/bin/bash

# 변수
gemvFolder=GEMV2PackageV1.2 # GEMV 폴더 명
numOfVehicles=10 # 자동차 개수

echo -e "\n\033[32;1mCity List: \033[m\n1. Busan\n2. SanFrancisco"
echo -e "\n\033[32;1mEnter the number(default SanFrancisco): \033[m"
read cityNum

if [ $cityNum == 1 ]; then
    cityName=Busan
    cityCoordinate=129.0530,35.1489,129.0690,35.1633
elif [ $cityNum == 2 ]; then
    cityName=SanFrancisco
    cityCoordinate=-122.4115,37.7814,-122.3899,37.7965
else
    cityName=SanFrancisco
    cityCoordinate=-122.4115,37.7814,-122.3899,37.7965
fi

echo -e "\n\033[32;1mCity: \033[m $cityName"
echo -e "\033[32;1mNumber of Vehicles: \033[m $numOfVehicles"

# SUMO 설치
echo -e "\n\033[32;1m***** Installing: \033[m SUMO \033[32;1m*****\033[m"
sudo add-apt-repository -y ppa:sumo/stable
sudo apt-get -y update
sudo apt-get install -y sumo sumo-tools sumo-doc

# Get osm file from OpenStreetMap
echo -e "\n\033[32;1m***** Getting osm file\033[m from OpenStreetMap \033[32;1m*****\033[m"
wget -O $gemvFolder/inputPolygon/$cityName.osm "https://api.openstreetmap.org/api/0.6/map?bbox=$cityCoordinate"

# Convert osm to net
echo -e "\n\033[32;1m***** Converting osm file to net file *****\033[m"
netconvert --osm $gemvFolder/inputPolygon/$cityName.osm -o $gemvFolder/inputPolygon/$cityName.net.xml --geometry.remove --ramps.guess --junctions.join --tls.guess-signals --tls.discard-simple --tls.join --remove-edges.by-type railway.subway

# Setup numOfVehicles vehicles' route
echo "***** Finding: randomTrips.py *****"
randomTripsPATH=$(sudo find / -name randomTrips.py 2>/dev/null)
echo "randomTripsPATH: $randomTripsPATH"
if [ -z "$randomTripsPATH" ]; then
    echo -e "\033[31mERROR\033[0m: Cannot find randomTrips.py (0)"
    exit 0
else
    echo -e "\n\033[32;1m***** Setting\033[m $numOfVehicles vehicles \033[32;1m*****\033[m"
    $randomTripsPATH -n $gemvFolder/inputPolygon/$cityName.net.xml -e $numOfVehicles -o $gemvFolder/inputPolygon/$cityName.trips.xml
fi

# Generate route file
echo -e "\n\033[32;1m***** Generating\033[m route file \033[32;1m*****\033[m"
duarouter -n $gemvFolder/inputPolygon/$cityName.net.xml --route-files $gemvFolder/inputPolygon/$cityName.trips.xml -o $gemvFolder/inputPolygon/$cityName.rou.xml --ignore-errors

# simulate
echo -e "\n\033[32;1m***** Simulating *****\033[m"
sumo -c $gemvFolder/$cityName.sumo.cfg
#gksudo sumo-gui -c $cityName.sumo.cfg --fcd-output $cityName-SUMOMobility.xml --fcd-output.geo true

echo "***** Finding: traceExporter.py *****"
traceExporterPATH=$(sudo find / -name traceExporter.py 2>/dev/null)
echo "traceExporterPATH: $traceExporterPATH"
if [ -z "$traceExporterPATH" ]; then
    echo -e "\033[31mERROR\033[0m: Cannot find traceExporter.py (0)"
    exit 0
else
    echo -e "\n\033[32;1m***** Generating tcl file *****\033[m"
    $traceExporterPATH --fcd-input $gemvFolder/inputMobilitySUMO/$cityName-mobility-trace.xml --ns2mobility-output=$gemvFolder/inputMobilitySUMO/$cityName-mobility-trace.tcl
fi




