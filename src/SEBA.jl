using LinearAlgebra

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

    S = zeros(size(V))
    # Perturb near-constant vectors
    for j = 1:r
        if maximum(V[:, j]) - minimum(V[:, j]) < 1e-14
            V[:, j] = V[:, j] .+ (rand(p) .- 1 / 2) * 1e-12
        end
    end

    # Initialise rotation
    if Rinit ≡ nothing
        Rnew = I
    else
        # Ensure orthonormality of Rinit
        F = svd(Rinit)
        Rnew = F.U * F.Vt
    end

    # Define soft-threshold function:  soft threshold scalar z by threshold μ
    soft_threshold(z, μ) = sign(z) * max(abs(z) - μ, 0)

    # Preallocate matrices
    R = zeros(r, r)
    S = zeros(p, r)

    iter = 0
    while norm(Rnew - R) > 1e-12 && iter < maxiter
        iter = iter + 1
        R = Rnew
        # Threshold to solve sparse approximation problem
        S .= soft_threshold.(V * R', μ)
        # Normalize columns of S
        foreach(normalize!, eachcol(S))
        # Polar decomposition to solve Procrustes problem
        F = svd(S' * V)
        Rnew = F.U * F.Vt
    end

    # Choose correct parity of vectors and scale so largest value is 1
    for i = 1:r
        S[:, i] = S[:, i] * sign(sum(S[:, i]))
        S[:, i] = S[:, i] / maximum(S[:, i])
    end

    # Sort so that most reliable vectors appear first
    ind = sortperm(vec(minimum(S, dims=1)), rev=true)
    S = S[:, ind]

    error = norm(Rnew - R)
    return S

end

