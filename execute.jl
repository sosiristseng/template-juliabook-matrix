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

outpath = joinpath(abspath(pwd()), cachedir, nb)
mkpath(dirname(outpath))

kernelname = "--ExecutePreprocessor.kernel_name=julia-1.$(VERSION.minor)"
execute = ifelse(get(ENV, "ALLOWERRORS", " ") == "true", "--execute --allow-errors", "--execute")
timeout = "--ExecutePreprocessor.timeout=" * get(ENV, "TIMEOUT", "-1")
cmd = `jupyter nbconvert --to notebook $(execute) $(timeout) $(kernelname) --output $(outpath) $(nb)`

run(cmd)
