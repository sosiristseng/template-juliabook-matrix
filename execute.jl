using Literate

file = get(ENV, "NB", "test.ipynb")
cachedir = get(ENV, "NBCACHE", ".cache") # Defaults to .cache/

if endswith(file, ".jl")
    Literate.notebook(file, dirname(file); mdstrings=true, execute=false)
    nb = splitext(file)[1] * ".ipynb"
elseif endswith(file, ".ipynb")
    nb = file
else
    error("$(file) is not a valid notebook file!")
end

outpath = joinpath(get(ENV, "GITHUB_WORKSPACE", pwd()), cachedir, nb)
mkpath(dirname(outpath))

kernelname = "--ExecutePreprocessor.kernel_name=julia-1.$(VERSION.minor)"
extraargs = get(ENV, "EXTRA_ARGS", "")
timeout = "--ExecutePreprocessor.timeout=" * get(ENV, "TIMEOUT", "-1")
output = "--output $(outpath)"
cmd = `jupyter nbconvert --to notebook --execute $(extraargs) $(timeout) $(kernelname) $(nb)`

run(cmd)
