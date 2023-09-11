using Pkg
Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile()

program = "jupyter nbconvert --to notebook --execute --inplace"
timeout = string("--ExecutePreprocessor.timeout=", ENV["TIMEOUT"])
kernel_name = "--ExecutePreprocessor.kernel_name=julia-1.$(VERSION.minor)"
options = ENV["EXTRA_ARGS"]
filename = ENV["FILENAME"]

run(`$program $timeout $kernel_name $options $filename`)
