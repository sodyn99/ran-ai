#!/bin/bash

# 변수
gemvFolder=GEMV2PackageV1.2 # GEMV 폴더 명

echo -e "\n\033[32;1m***** Installing: \033[m Update & Upgrade & essential package \033[32;1m*****\033[m"
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y build-essential

echo -e "\n\033[32;1m***** Installing: \033[m git \033[32;1m*****\033[m"
sudo apt install -y git

# 구글 크롬 다운로드
# https://www.google.com/chrome/?platform=linux 에서 다운로드 가능
# echo -e "\n\033[32;1m***** Installing: \033[m google-chrome \033[32;1m*****\033[m"
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo apt install ./google-chrome-stable_current_amd64.deb

# echo -e "\n\033[32;1m***** Installing: \033[m osmconvert \033[32;1m*****\033[m"
# sudo apt install -y zlib1g-dev
# sudo apt install -y osmctools && wget -O - http://m.m.i24.cc/osmconvert.c | sudo cc -x c - -lz -O3 -o osmconvert

# wireshark 설치
echo -e "\n\033[32;1m***** Installing: \033[m Wireshark \033[32;1m*****\033[m"
sudo add-apt-repository -y ppa:wireshark-dev/stable
sudo apt -y update
sudo apt -y install wireshark
echo -e "\n\033[32;1mWireshark Version Check \033[m"
wireshark --version

echo -e "\n\033[32;1m***** Installing: \033[m python3 \033[32;1m*****\033[m"
sudo apt install -y python3-pip
pip install py_interface

# GEMV2 설치 (https://vehicle2x.net/download/)
echo -e "\n\033[32;1m***** Installing: \033[m GEMV \033[32;1m*****\033[m"
wget -O $gemvFolder.zip https://vehicle2x.net/download/gemv2-package-v1-2/?wpdmdl=381
unzip $gemvFolder.zip
rm $gemvFolder.zip

# sumo 파일 복사
cp -r SUMO/SanFrancisco $gemvFolder/inputPolygon

# config 파일 복사
# cp SUMO/Busan/Busan.sumocfg $gemvFolder/Busan.sumocfg
# cp SUMO/SanFrancisco/SanFrancisco.sumocfg $gemvFolder/SanFrancisco.sumocfg

echo -e "\033[32;1mAll configurations are complete.\033[m"
echo -e "\033[33mMatlab must be downloaded directly via https://kr.mathworks.com/downloads/.\033[0m"
echo -e "\033[33mAlso, if the GEMV download is not complete, please download it directly via https://vehicle2x.net/download/.\033[0m"