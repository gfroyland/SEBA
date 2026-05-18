using Plots, LinearAlgebra, ProgressMeter

include("SEBA.jl")

"""
    MinValStackedPlot(V)

`V` is a p×R matrix (R vectors of length p as columns, assumed orthonormal).

"""

function MinValStackedPlot(V)
    R = size(V, 2)
    kmax = R
    column_minima = fill(NaN, R - 1, R)

    @showprogress Threads.@threads for i = 1:R-1
        S = SEBA(V[:, 1:i+1])   # Column minima are in descending order
        column_minima[i, 1:i+1] = -vec(minimum(S, dims=1))
    end

    minimum_sums = cumsum(column_minima, dims=2)

    # MATLAB's min ignores NaN; replace NaN with Inf so Julia's argmin/minimum behave the same
    ms_nonan = replace(minimum_sums, NaN => Inf)
    best_sum_vals = vec(minimum(ms_nonan, dims=1))
    best_r_vals = vec(mapslices(argmin, ms_nonan, dims=1))

    p = plot(legend=false, dpi=300)
    for j = 1:kmax
        iStart = max(j - 1, 1)
        plot!(p, (iStart+1):R, minimum_sums[iStart:R-1, j],
            markershape=:circle, markersize=2, linewidth=1.5)
    end

    # Plot best r for each k (filled black diamonds)
    scatter!(p, best_r_vals[1:kmax] .+ 1, best_sum_vals[1:kmax],
        markershape=:diamond, markersize=4,
        markercolor=:black, markerstrokecolor=:black, color=:black)

    # Plot upper envelope (dotted black line)
    # Corresponds to MATLAB linear indices [1, R:R:R*(kmax-1)] in column-major (R-1)×R matrix,
    # which maps to elements (1,1), (1,2), (2,3), ..., (kmax-1, kmax)
    x_env = [2; collect(2:kmax)]
    y_env = [minimum_sums[1, 1]; [minimum_sums[j, j+1] for j in 1:kmax-1]]
    plot!(p, x_env, y_env, linestyle=:dot, color=:black, markershape=:none)
    display(p)

    return column_minima

end
