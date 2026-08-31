function SEBA(V, Rinit=nothing)

    # Inputs: 
    # V is pxr matrix (r vectors of length p as columns)
    # Rinit is an (optional) initial rotation matrix.

    # Outputs:
    # S is pxr matrix with columns approximately spanning the column space of V
    # R is the optimal rotation that acts on V, which followed by thresholding, produces S

    # Begin SEBA algorithm

    maxiter = 5000   # maximum number of iterations allowed
    F = qr(V) # Enforce orthonormality
    V = Matrix(F.Q)
    p, r = size(V)
    μ = 0.99 / sqrt(p)

    # Perturb near-constant vectors
    for j = 1:r
        if maximum(V[:, j]) - minimum(V[:, j]) < 1e-14
            V[:, j] = V[:, j] .+ (rand(p) .- 1 / 2) * 1e-12
        end
    end

    # Initialise rotation
    if Rinit ≡ nothing
        Rnew = CuArray(Matrix(I, r, r))
    else
        # Ensure orthonormality of Rinit
        F = svd(CuArray(Rinit))
        Rnew = F.U * F.Vt
    end

    # Define soft-threshold function:  soft threshold scalar z by threshold μ
    soft_threshold(z, μ) = sign(z) * max(abs(z) - μ, 0)

    # Switch V to a CuArray
    V = CuArray(V)

    # Preallocate matrices R and S as CuArrays
    R = CuArray(zeros(r, r))
    S = CuArray(zeros(p, r))

    iter = 0
    while norm(Rnew - R) > 1e-12 && iter < maxiter
        iter = iter + 1
        R = Rnew
        # Threshold to solve sparse approximation problem
        S .= soft_threshold.(V * R', μ)
        # Normalize columns of S
        foreach(normalize!, eachcol(S))
        # Polar decomposition to solve Procrustes problem
        F = svd(S' * V, full=false)
        Rnew = F.U * F.Vt
    end

    # Move R, Rnew and S back to the CPU
    R = Array(R)
    Rnew = Array(Rnew)
    S = Array(S)

    # Choose correct parity of vectors and scale so largest value is 1
    for i = 1:r
        S[:, i] .= S[:, i] * sign(sum(S[:, i]))
        S[:, i] .= S[:, i] / maximum(S[:, i])
    end

    # Sort so that most reliable vectors appear first
    ind = sortperm(vec(minimum(S, dims=1)), rev=true)
    S = S[:, ind]

    return S

end
