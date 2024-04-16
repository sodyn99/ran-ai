#!/bin/bash

###
# ns3-mmwave: https://github.com/nyuwireless-unipd/ns3-mmwave.git
# ns3-ai: https://github.com/hust-diangroup/ns3-ai.git
###

gemvFolder=GEMV2PackageV1.2 # GEMV 폴더 명
ns3Version=3.38 # ns3 버전
mmwaveVersion=v7.0 # ns3-mmwave 버전
aiVersion=v1.2.0 # ns3-ai 버전 / v1.2.0: Ubuntu 22.04 이상 필요

echo -e "\n\033[32;1m***** Installing: \033[m Update & Upgrade & essential package \033[32;1m*****\033[m"
sudo apt update -y
sudo apt install -y build-essential

echo -e "\n\033[32;1m***** Installing: \033[m git \033[32;1m*****\033[m"
sudo apt install -y git

echo -e "\n\033[32;1m***** Installing: \033[m tar \033[32;1m*****\033[m"
sudo apt install -y tar

echo -e "\n\033[32;1m***** Installing: \033[m bunzip2 \033[32;1m*****\033[m"
sudo apt install -y bzip2

echo -e "\n\033[32;1m***** Installing: \033[m python3 \033[32;1m*****\033[m"
sudo apt install -y python3

echo -e "\n\033[32;1m***** Installing: \033[m cmake \033[32;1m*****\033[m"
sudo snap install cmake --classic

echo -e "\n\033[32;1m***** Installing: \033[m Requirements for ns3-ai \033[32;1m*****\033[m"
sudo apt install -y libboost-all-dev # Boost C++ libraries
sudo apt install -y libprotobuf-dev protobuf-compiler # Protocol buffers
sudo apt install -y pybind11-dev # pybind11

# ns3-mmwave 다운로드
git clone https://github.com/nyuwireless-unipd/ns3-mmwave.git ns3
cd ns3
git checkout $mmwaveVersion

# ns3 빌드
./ns3 configure --enable-examples --enable-tests
./ns3 build

# ns3-ai 다운로드
git clone https://github.com/hust-diangroup/ns3-ai.git contrib/ai
cd contrib/ai
git checkout $aiVersion
cd ../..

./ns3 build ai

cd ..

# GEMV 시뮬레이션 결과 파일 복사
rsync -a GEMV/$gemvFolder/outputSim/ ns3/input
