# Irmin on Cassandra

## Build Instructions
1. Clone the repository at `https://github.com/njayinthehouse/irmin-scylla` to 
this project's root directory.
2. Clone the repository at `https://github.com/njayinthehouse/ocaml-git` to this
project's root directory.
3. Clone the repository at `https://github.com/datastax/cpp-driver` to this 
project's root directory.
3. Copy the files `libcassandra.so` and `libcassandra.a` to 
`irmin-scylla/irmin-master/src/libcassandra/cpp-driver`.
4. Build the docker image from the Dockerfile.

## Documentation
This repository can be divided into the following parts:
1. The C++ driver for running Cassandra. This is implemented using datastax's 
`cpp-driver` repository. Following the instructions [here](https://github.com/datastax/cpp-driver)
helps install the driver and build the libcassandra static archive and shared
object files. 
2. The OCaml wrapper on the C++ driver. For this, I've used Shashank's 
`irmin-scylla` repository; it has a nice wrapper called libcassandra. Build 
instructions are [here](https://github.com/njayinthehouse/irmin-scylla). One of the 
first steps is moving the `libcassandra.a` and `libcassandra.so` files to
`irmin-scylla/irmin-master/src/libcassandra/cpp-driver`. However, please note that
the files moved above are *not* the same as the files built in the previous step.
In the past, I tried using the files built; however, it resulted in linker errors.
When I tried copying the files that Shashank had built from some previous unknown
version of the `cpp-driver` repository, the error was resolved. Thus, we use the
files that Shashank had sent me.
3. The mirage implementation of git in OCaml, with my code. This is where we wrote
our implementation of a file system on Cassandra. I want to be able to test this
using the repository's tests for the unix file system module that they implement.

More detailed logs of past approaches can be found [here](https://gist.github.com/njayinthehouse/bfc162c10953dd88e1048c6b4bc7be7c).

## Current Problems
We get a linker error whenever we try building `git-unix`. This error started 
showing up when I moved the code from the file system on Cassandra from the 
`irmin-scylla` repository to `ocaml-git`. At first, I thought it was a problem 
with my docker environment; I had built the container using non-standard methods,
and it was giving me other problems already. That's one of the reasons I wrote up a
proper Dockerfile. This did not solve the issue. Next, I tried adding the directory
containing the `libcassandra.a` file to the linker search path. That didn't work,
either. 
