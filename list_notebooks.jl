import Pkg
Pkg.add("JSON")

basedir = "docs"
nbs = String[]

# Collect the list of notebooks
for (root, dirs, files) in walkdir(basedir)
    for file in files
        if (endswith(file, ".ipynb"))
            # Store paths relative to the basedir
            newpath = splitpath(joinpath(root, file))[2:end] |> joinpath
            push!(nbs, newpath)
        end
    end
end

import JSON
print(JSON.json(nbs))
