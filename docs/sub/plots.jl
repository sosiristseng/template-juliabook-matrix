#===
# Plotting by Plots.jl

Using Literate.jl
===#
using Plots
using Random
Random.seed!(2022)

#---
plot(rand(1:6, 5))

# ## Runtime information
import Pkg
Pkg.status()

#---
import InteractiveUtils
InteractiveUtils.versioninfo()
