FROM ubuntu:focal
WORKDIR /app 
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get -y install wget
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb
RUN apt-get update -y
RUN apt-get -y install dotnet-sdk-6.0 git cmake ninja-build build-essential libssl-dev pkg-config libboost-all-dev libsodium-dev libzmq5-dev libgmp-dev
COPY . .
WORKDIR /app/src/Miningcore
RUN dotnet publish -c Release --framework net6.0 -o ../../build
WORKDIR /app/build
CMD ["/app/build/Miningcore", "-c", "/app/config.json" ]
