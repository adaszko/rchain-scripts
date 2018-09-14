# rchain-scripts
Simple RChain Scripts


# Building Preloaded Ubuntu Image

docker build .
docker run -v $(pwd):/root/rchain-scripts -it cd6d8154f1e1 /bin/bash
