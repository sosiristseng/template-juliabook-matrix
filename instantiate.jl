using Pkg
Pkg.add(["Literate", "JSON", "CondaPkg"])

using CondaPkg
CondaPkg.add("jupyter")
CondaPkg.add("nbconvert")
ENV["JUPYTER"] = CondaPkg.which("jupyter")
Pkg.add("IJulia")

Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile()
