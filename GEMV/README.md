# GEMV 시뮬레이션

## 차량 대수 수정(option)

`sumo.sh` 파일의 numOfVehicles 수정 (default 10)

## Configuration

```bash
bash ./setup.sh
bash ./sumo.sh
```

## Matlab 파일 수정

`simSetting.m` 파일을 수정 해야 한다.

```matlab
%% Different "pre-installed" scenarios
%   1 - Porto entire city
%   2 - Porto quarter of the city
%   3 - Cologne
%   4 - Newcastle
%   5 - Bologna (scenario with both V2V and V2I)
%   6 - Busan % --- 추가
%   7 - SanFranciso % --- 추가
scenario = 7; % --- 수정
```

```matlab
switch scenario
    ...
    % --- 아래에 case 6, 7 추가
    case 6
        % SUMO simulation in the city of Busan, KR
        vehiclesFile = 'inputMobilitySUMO/Busan-mobility-trace.xml';
        bBoxVehicles = [129.0530,35.1489,129.0690,35.1633];        
        % Buildings in part of Busan, KR (OpenStreetMap .osm)
        staticFile = 'inputPolygon/Busan/Busan_bbox.osm';
        V2XNames = {'V2V', 'V2I'};
    case 7
        vehiclesFile = 'inputMobilitySUMO/SanFrancisco-mobility-trace.xml';
        bBoxVehicles = [-122.4115,37.7814,-122.3899,37.7965];
        staticFile = 'inputPolygon/SanFrancisco/SanFrancisco_bbox.osm';
        V2XNames = {'V2V', 'V2I'};
```

```matlab
%% Google Earth Visualization 
% NB: in case of large networks, generating the visualization can take very
% long time. Use accordingly.
GEVisualize = 1;
    % IF GEVisualize = 1, then parameters below indicate what is plotted.
    % Plot static objects and vehicle polygons
    plotPoly = 1; % --- 수정(option)
    % Plot the received power for each of the communications pairs
    plotRxPwr = 1;
    % Plot the number of neighbors per vehicle
    plotNeighbors = 1;
```

## GEMV 시뮬레이션 실행

```matlab
>> runSimulation
```
