# Load libraries
using Random
using StatsBase
Random.seed!(511)

# Boston mechanism function
function boston_mechanism(G, C, P)
    println("Starting new call....\n")
    A = Dict()
    step = 0
    
    # Repeat algorithm as long as there are unassigned groups, counting the steps
    while length(A) < length(G)
        step += 1
        println("step: $step")

        # Go through every option
        for (option, capacity) in enumerate(C)
            print("option: $(option - 1), ")
            
            # Check capacity of option
            try
                global n_assigned_option = sum(i -> i == option - 1, values(A))
                print("N_before:$n_assigned_option, ")
                # Skip this option if at capacity
                if n_assigned_option == capacity
                    println("option full!")
                    continue
                end
            catch e
                print("A is empty, ")
                global n_assigned_option = 0
            end
            
            # If not at capacity, go through groups to collect candidates for current option
            is_candidate = []
            for (group, name) in enumerate(G)
                # Skip group if already assigned
                if name in keys(A)
                    push!(is_candidate, 0)
                    continue
                end
                # Else extract choice and mark as candidate if choice is equal to current option
                choice = P[group, step]
                push!(is_candidate, Int(choice == option - 1))
            end
            
            # Compute and collect indices of candidates for current option
            candidates = findall(x -> x == 1, is_candidate)
            print("candidates: $candidates, ")
            
            # Skip current option if no candidates
            if length(candidates) == 0
                print("\n")
                continue
            end
            
            # Select candidates up to capacity
            remaining_capacity = capacity - n_assigned_option
            print("remaining capacity: $remaining_capacity, ")
            
            if length(candidates) <= remaining_capacity
                chosen = candidates 
            else
                # chosen = candidates[rand(1:length(candidates))]
                chosen = sample(candidates, Int(remaining_capacity), replace = false)
            end
                print("chosen: $chosen, ")

            # Add to A if topic not in A
            for each in chosen
                merge!(A, Dict(G[each] => option - 1))
            end
            println("A now is: $A")
        end
        println("#"^40)
    end
    return(A)
end

# Set parameters
Random.seed!(511)
G1 = ("γ", "τ", "ι", "ϕ", "δ", "ω", "θ", "λ")
C1 = [5 1 1 1 1 1 1]
P1 = [
    3 4 1 2 6 0 5; # γ
    1 3 4 0 5 6 2; # τ
    6 0 5 1 3 4 2; # ι
    0 4 5 1 3 2 6; # ϕ
    6 1 2 3 5 4 0; # δ
    0 4 6 5 1 3 2; # ω
    1 6 4 3 5 2 0; # θ
    6 5 1 4 2 3 0 # λ
]


topics = boston_mechanism(G1, C1, P1);


### Dates

C2 = [Inf 1 1 1]

## Filter set of groups to select only groups with an assigned topic

# Find indices of selected groups
selected_groups = keys(filter(p -> last(p) != 0, topics))

# This is not great...
selected_indices = []
for (group, name) in enumerate(selected_groups)
    push!(selected_indices, findfirst(x -> x == name, G1))
end

# Filter groups (never use tuples again!)
v = [G1...]
G_selected = v[filter(x -> (x in selected_indices), axes(v, 1))]
G_selected = (G_selected...,)



# Filter date preferences for selected groups only
P_selected = [
    2 3 1 0; # γ
    3 2 1 0; # τ
    3 2 1 0; # ι
    3 2 1 0; # ϕ
    3 2 1 0; # δ
    3 2 1 0; # ω
    1 2 3 0; # θ
    1 2 3 0 # λ
]
P_selected = P_selected[filter(x -> (x in selected_indices), axes(P_selected, 1)), axes(P_selected, 2)]

# P_selected = 
# 2  3  1  0   "γ" *
# 3  2  1  0   "δ" *
# 3  2  1  0   "ω"
# 1  2  3  0   "θ"
# 1  2  3  0   "λ" *

dates = boston_mechanism(G_selected, C2, P_selected)


### Discussants

C3 = [2 1 1 1]

# Find indices of discussant groups
# discuss_groups = keys(filter(p -> last(p) == 0, topics))
G_discuss = ("τ", "ι", "ϕ", "ω", "θ")
discuss_indices = [2, 3, 4, 6, 7]
P_discuss = P1[filter(x -> (x in discuss_indices), axes(P1, 1)), axes(P1, 2)]

discussants = boston_mechanism(G_discuss, C3, P_discuss)