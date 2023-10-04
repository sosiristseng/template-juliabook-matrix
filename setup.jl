using Pkg
Pkg.add(["IJulia"])

import IJulia
IJulia.installkernel("Julia", "--project=@.")

Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile()
Pkg.gc()
