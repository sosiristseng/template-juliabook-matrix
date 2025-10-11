using Pkg: Pkg
Pkg.add(["Literate", "JSON"])
Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile()

# Trigger matplotlib dependencies
# try
#     using PythonPlot
# catch e
#     @warn "Error initializing PythonPlot" exception=(e, catch_backtrace())
# end
