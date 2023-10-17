using Pkg
Pkg.add(["IJulia"])

Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile()
