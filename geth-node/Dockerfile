FROM ubuntu:18.04

ARG goversion=1.15.2
ARG gethversion=v1.9.25
ARG gohost=linux-amd64.tar.gz

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]

RUN apt-get update

RUN apt-get install build-essential wget git -y && rm -rf /var/lib/apt/lists/*

# ----- INSTALL Golang -----
RUN wget https://dl.google.com/go/go$goversion.$gohost && apt-get remove wget -y

RUN tar -xvf go$goversion.$gohost && rm -rf go$goversion.$gohost

RUN mv go /usr/local/

# Set environment variables
ENV GOROOT=/usr/local/go
ENV GOPATH=$HOME/go_work
ENV PATH="$GOROOT/bin:$GOPATH/bin:${PATH}"

WORKDIR /app

# ----- INSTALL GETH BY DOWNLOADING SOURCE CODE -----
# Get geth source code
RUN git clone --branch $gethversion https://github.com/ethereum/go-ethereum
# Build geth
RUN cd go-ethereum && make geth
# Add geth to environment variables
ENV PATH="${PATH}:/app/go-ethereum/build/bin"

# COPY privatechain.json .

# ----- COPY SHELL SCRIPT & GIVE RIGHTS TO EXECUTE IT -----
COPY run.sh .
RUN chmod +x ./run.sh




# RUN geth init --datadir ./data privatechain.json

# ENTRYPOINT [ "geth init --datadir ./data privatechain.json", "&&" ]

# ENTRYPOINT [ "bash", "./run.sh", "data", "privatechain" ]

# ----------------------------------------- not used just to remember
# CMD geth init --datadir ./data privatechain.json && geth --networkid 5333 --datadir ./data --nodiscover --http --http.port "8545" --port "30303" --http.corsdomain "*" --http.addr "0.0.0.0" --http.api="eth,net,personal,web3,debug,admin,miner"

# CMD geth --networkid 5333 --datadir ./data --nodiscover --http --http.port "8545" --port "30303" --http.corsdomain "*" --http.addr "0.0.0.0" --http.api="eth,net,personal,web3,debug,admin,miner"
