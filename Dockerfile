FROM ubuntu:18.04

RUN apt-get update -yqq
RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt-get update -yqq
RUN apt install -y docker-ce sudo wget curl
RUN apt install -y python3 python3-pip
RUN apt-get update -yqq
RUN apt-get install g++-multilib -yqq
RUN apt-get install cmake curl git -yqq
RUN apt-get install openjdk-11-jdk -yqq
RUN apt-get install haskell-platform -yqq
RUN apt-get install apt-transport-https -yqq
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update -yqq
RUN apt-get install sbt -yqq
RUN apt-get install jflex -yqq
RUN apt-get install autoconf libtool -yqq
RUN apt-get -yq install rpm
RUN apt-get -yq install fakeroot

RUN mkdir /tmp/protobuf_build
WORKDIR /tmp/protobuf_build
RUN wget https://github.com/google/protobuf/releases/download/v3.5.1/protobuf-cpp-3.5.1.tar.gz
RUN tar -xzf protobuf-cpp-3.5.1.tar.gz
WORKDIR /tmp/protobuf_build/protobuf-3.5.1
RUN ./configure --build=i686-pc-linux-gnu CFLAGS="-m32 -DNDEBUG" CXXFLAGS="-m32 -DNDEBUG" LDFLAGS=-m32
RUN make
RUN make check
RUN sudo make install
RUN sudo ldconfig


RUN mkdir /tmp/rchain_build
WORKDIR /tmp/rchain_build
RUN git clone https://github.com/rchain/rchain
WORKDIR rchain

RUN cd rosette && ./build.sh
RUN apt -y install ./rosette/build.out/rosette-*.deb

RUN python3.6 -m pip install docker argparse pexpect requests

RUN ./scripts/install_bnfc.sh
