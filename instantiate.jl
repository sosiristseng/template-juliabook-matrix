using Pkg
Pkg.add("CondaPkg")

using CondaPkg
CondaPkg.add(["jupyter", "nbconvert", "matplotlib"])
ENV["JUPYTER"] = CondaPkg.which("jupyter")
Pkg.add(["IJulia", "Literate", "JSON"])

Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile()
