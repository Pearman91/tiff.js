docker build --pull --rm -f "Dockerfile" -t libtiffwasm:latest "." 
docker rm libtiffwasm
docker run --name libtiffwasm -v ./build:/build libtiffwasm:latest