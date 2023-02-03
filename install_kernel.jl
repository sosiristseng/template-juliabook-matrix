import Pkg
Pkg.add("IJulia")

using IJulia
p = installkernel("Julia", "--project=@.")

symlink(p, joinpath(dirname(p), "julia"), dir_target=true)
