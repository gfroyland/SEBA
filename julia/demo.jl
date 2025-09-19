using Plots

include("SEBA.jl")

grid = 0:0.1:2π
numvecs = 4
V = [cos.((k / 2) * x) for x ∈ grid, k = 0:numvecs-1]

S = SEBA(V)

data_plot = plot(grid, V, legend=false, title="$numvecs original vectors")
SEBA_plot = plot(grid, S, legend=false, title="$numvecs sparse SEBA vectors with similar span")

plot(data_plot, SEBA_plot, layout=(2, 1))

