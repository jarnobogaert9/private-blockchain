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

# ----- COPY SHELL SCRIPT & GIVE RIGHTS TO EXECUTE IT -----
COPY run.sh .
RUN chmod +x ./run.sh
