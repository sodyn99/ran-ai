# GEMV 시뮬레이션

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
scenario = 6; % --- 수정
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
        staticFile = 'inputPolygon/Busan.osm';
    case 7
        vehiclesFile = 'inputMobilitySUMO/SanFrancisco-mobility-trace.xml';
        bBoxVehicles = [-122.4115,37.7814,-122.3899,37.7965];
        staticFile = 'inputPolygon/SanFrancisco.osm';
```

## GEMV 시뮬레이션 실행

```matlab
>> runSimulation
```