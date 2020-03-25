FROM ocaml/opam2:latest
WORKDIR /home/opam
COPY cpp-driver cpp-driver 
COPY irmin-scylla/irmin-master/src/libcassandra libcassandra
RUN opam switch 4.09\
 && sudo chmod ugo+wx cpp-driver cpp-driver/src cpp-driver/src/third_party/sparsehash/src/sparsehash/internal\
 && sudo apt install -y build-essential cmake libkrb5-dev libgmp-dev libssl-dev\
                        zlib1g-dev m4 pkg-config libuv1-dev libffi-dev\
 && mkdir -m 777 cpp-driver/build && cd cpp-driver/build\
 && sudo cmake .. && sudo make && sudo make install && cd ~\
 && opam install -y ctypes ctypes-foreign posix-types dune-configurator irmin-unix\
                    alcotest nocrypto\
 && eval $(opam env)\
 && opam pin libcassandra -k path libcassandra
