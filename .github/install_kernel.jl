import Pkg
Pkg.add("IJulia")

using IJulia
p = installkernel("Julia", "--project=@.")
newpath = joinpath(dirname(p), "julia")

@info "Creating symlink " newpath " pointing to" p
symlink(p, newpath, dir_target=true)
