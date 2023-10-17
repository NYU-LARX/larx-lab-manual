# Julia

[Julia](https://julialang.org/) is a programming language combining C, Python, and MATLAB advantages. It is designed for high-performance computing and has been widely used in the academia.

Julia offers precompiled binaries for different platforms. Therefore, we can directly download the binaries and add them to the `PATH` environment variable without compiling from the source.

### Install Julia
First, download Julia tarball from the [downlad page](https://julialang.org/downloads/). Select the proper platform.

Then, unzip the tarball and move it to `/home/username/opt/`.
```bash
$ tar xf julia-xxx
$ mkdir /home/username/opt/julia-xxx    # follow the version convention
$ cd julia-xxx && mv . /home/username/opt/julia-xxx
```

Finally, update the `PATH` environment variable.
```bash
$ export PATH="${PATH}:/home/username/opt/julia-xxx/bin"
```
