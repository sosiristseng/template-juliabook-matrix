using Pkg
Pkg.add("CondaPkg")

using CondaPkg
CondaPkg.add(["jupyter", "nbconvert", "matplotlib"])
ENV["JUPYTER"] = CondaPkg.which("jupyter")
Pkg.add(["IJulia", "Literate", "JSON"])

ENV["JULIA_CONDAPKG_OFFLINE"] = true
Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile()
