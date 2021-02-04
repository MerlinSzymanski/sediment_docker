FROM teeks99/gcc-ubuntu:5

#install bwa
RUN apt-get update && \
    apt-get install -y \ 
        zlib1g-dev \ 
        git \
        pkg-config \
        libzmq3-dev

RUN git clone -b 0.5.10-evan.10 --depth 1 https://github.com/mpieva/network-aware-bwa && \
    cd network-aware-bwa && \
    make

#Set Up Haskell
RUN apt-get install -y \
        ghc \
        ghc-prof \
        ghc-doc \
        cabal-install \
        libjudy-dev && \
    add-apt-repository -y ppa:hvr/ghc && \
    apt-get update && \
    apt-get install -y \
        cabal-install-1.18 \
        ghc-7.8.3

RUN cabal update && \
    cabal install \
        mmorph-1.1.3 \
        cabal-install-1.18.0

#Install Biohazard
RUN git clone https://github.com/mpieva/biohazard.git && \
    /root/.cabal/bin/cabal install -w /opt/ghc/bin/ghc biohazard/

#Install Biohazard-tools
RUN git clone https://github.com/mpieva/biohazard-tools && \
    /root/.cabal/bin/cabal install --force-reinstalls -w /opt/ghc/bin/ghc biohazard-tools/

RUN cp /root/.cabal/bin/* /bin/

