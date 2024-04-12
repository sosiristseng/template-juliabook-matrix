using Literate
using Pkg
Pkg.activate(Base.current_project())

file = get(ENV, "NB", "test.ipynb")
cachedir = get(ENV, "NBCACHE", ".cache")

function main(; rmsvg=true)
    if endswith(file, ".jl")
        run_literate(file; rmsvg)
    elseif endswith(file, ".ipynb")
        run_ipynb(file)
    else
        error("$(file) is not a valid notebook file!")
    end
end

# Remove SVG output from a Jupyter notebook
function remove_svg(nb)
    for cell in nb["cells"]
        !haskey(cell, "outputs") && continue
        for output in cell["outputs"]
            !haskey(output, "data") && continue
            datadict = output["data"]
            delete!(datadict, "text/html")
            delete!(datadict, "image/svg+xml")
        end
    end
    return nb
end

function run_literate(file; rmsvg=true)
    outpath = joinpath(abspath(pwd()), cachedir, dirname(file))
    mkpath(outpath)
    postprocess = rmsvg ? remove_svg : identity
    Literate.notebook(file, outpath; mdstrings=true, execute=true, postprocess)
end

function run_ipynb(file)
    outpath = joinpath(abspath(pwd()), cachedir, nb)
    mkpath(dirname(outpath))
    kernelname = "--ExecutePreprocessor.kernel_name=julia-1.$(VERSION.minor)"
    execute = get(ENV, "ALLOWERRORS", " ") == "true" ? "--execute --allow-errors" : "--execute"
    timeout = "--ExecutePreprocessor.timeout=" * get(ENV, "TIMEOUT", "-1")
    cmd = `jupyter nbconvert --to notebook $(execute) $(timeout) $(kernelname) --output $(outpath) $(nb)`
    run(cmd)
end

main()
