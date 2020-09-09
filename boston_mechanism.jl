using Random
Random.seed!(511)

γ = (
    rPrefs = (3, 4, 1, 2, 6, 0, 5),
    rDates = (2, 3, 1)
)
τ = (
    rPrefs = (1, 3, 4, 0, 5, 6, 2),
    rDates = (3, 2, 1)
)
ι = (
    rPrefs = (6, 0, 5, 1, 3, 4, 2),
    rDates = (3, 2, 1)
)
ϕ = (
    rPrefs = (0, 4, 5, 1, 3, 2, 6),
    rDates = (3, 2, 1)
)
δ = (
    rPrefs = (6, 1, 2, 3, 5, 4, 0),
    rDates = (3, 2, 1)
)
ω = (
    rPrefs = (0, 4, 6, 5, 1, 3, 2),
    rDates = (3, 2, 1)
)
θ = (
    rPrefs = (1, 6, 4, 3, 5, 2, 0),
    rDates = (1, 2, 3)
)
λ = (
    rPrefs = (6, 5, 1, 4, 2, 3, 0),
    rDates = (1, 2, 3)
)

I0 = (
    γ = γ,
    τ = τ,
    ι = ι,
    ϕ = ϕ,
    δ = δ,
    ω = ω,
    θ = θ,
    λ = λ
)
C0 = (1:6)

# Define function for Boston algorithm
function boston_mechanism(I, C, rank)
    A = Dict()
    mech_step = 0
    while length(A) < length(C)
    # for i in 1:1
        mech_step += 1
        for option in C
            # Skip option if already assigned
            if option in values(A)
                continue
            end
            # Collect list of candidates for current option
            is_candidate = []
            for group in keys(I)
                # Skip this group if it has been assigned
                if haskey(A, group)
                    push!(is_candidate, 0)
                    continue
                end
                value = I[group][rank][mech_step]
                if value == 0
                    push!(is_candidate, 0)
                    merge!(A, Dict(group => 0))
                else
                    push!(is_candidate, Int(value == option))
                end
            end
            candidates = findall(x -> x==1, is_candidate)

            # Skip current option if no candidates
            if length(candidates) == 0
                continue
            end

            # Choose one group randomly if there are several candidates
            chosen = candidates[rand(1:length(candidates))]
            merge!(A, Dict(keys(I)[chosen] => option))
        end
    end
    return A
end

# Run algorithm for topics
topics = boston_mechanism(I0, C0, 1);

X = filter(p -> last(p) != 0, topics)

# Run algorithm for dates
I1 = (
    γ = γ,
    τ = τ,
    λ = λ,
    δ = δ
)
dates = boston_mechanism(I1, (1:3), 2);