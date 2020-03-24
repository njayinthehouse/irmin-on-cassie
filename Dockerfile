FROM ocaml/opam2:latest
WORKDIR /home/opam
COPY irmin-scylla/irmin-master/src/libcassandra libcassandra
RUN sudo apt install -y build-essential cmake libkrb5-dev libssl-dev zlib1g-dev m4 pkg-config libuv1-dev libffi-dev\
 && opam install -y ctypes ctypes-foreign posix-types dune-configurator\
 && eval $(opam env)\
 && opam pin libcassandra -k path libcassandra
