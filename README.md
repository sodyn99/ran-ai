# RAN-AI

M. Drago의 *Artificial Intelligence in Vehicular Wireless Networks: A Case Study Using ns-3*를 follow 하기 위한 repository.

Original Github &rarr; [ns3-ran-ai](https://github.com/signetlabdei/ns3-ran-ai)

## Requirements

- Ubuntu 22.04

- git

    ```bash
    sudo apt install git
    ```

- code

    ```bash
    git clone https://github.com/sodyn99/ran-ai.git
    ```

- [Matlab](https://kr.mathworks.com/downloads/)

- Anaconda

    ```bash
    sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
    # https://docs.anaconda.com/free/anaconda/allpkglists/
    curl --output anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
    shasum -a 256 anaconda.sh # 무결성 확인
    bash ./anaconda.sh
    source ~/.bashrc
    ```

    ```bash
    conda -V
    conda list
    anaconda-navigator
    ```

    ```bash
    # The base environment is activated by default
    conda config --set auto_activate_base True

    # The base environment is not activated by default
    conda config --set auto_activate_base False
    ```

## Mobility, Channel Model

Go to [GEMV](/GEMV/README.md)

## Network Model

- [ns3](https://www.nsnam.org/releases/ns-3-38/documentation/) v3.38
- [ns3-mmwave](https://github.com/nyuwireless-unipd/ns3-mmwave.git) v7.0
- [ns3-ai](https://github.com/hust-diangroup/ns3-ai.git) v1.2.0

```bash
bash ./ns3-setup.sh
```

### ns3 빌드

```bash
cd ns3
```

```bash
./ns3 clean
./ns3 configure --enable-examples --enable-tests
./ns3 build
```

```bash
conda create -n ns3 python=3.10
conda activate ns3
```

```bash
cd contrib/ns3-ai/py_interface
pip3 install . --user
cd ../../..
```

```bash
conda install numpy tensorflow
```

### ns3-ai 예제

- [A_PLUS_B](https://github.com/hust-diangroup/ns3-ai/tree/master/examples/a_plus_b)

    ```bash
    cp -r contrib/ns3-ai/examples/a_plus_b scratch/
    cd scratch/a_plus_b/
    python3 run.py
    ```

- LTE_CQI

    ```bash
    cp -r contrib/ns3-ai/examples/lte_cqi scratch/
    cd scratch/lte_cqi/
    python3 run_online_lstm.py 1
    ```