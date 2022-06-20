# Adapted from https://github.com/terasakisatoshi/sysimage_creator/
using Pkg
Pkg.instantiate()

nthreads = Threads.nthreads()

using IJulia
IJulia.installkernel(
    "Julia",
    "--project=@.";
    env=Dict("JULIA_NUM_THREADS" => "$(nthreads)",)
)
