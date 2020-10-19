### Libraries
using Random
Random.seed!(511)

### Data

groups_presented = Set(["λ", "γ", "δ"])
groups_commented = Set(["ι", "τ", "ϕ"])

# Groups' topic preferences
topic_prefs = Dict(
    "δ" => ["B", "C", "D", "E", "F", "A"],
    "γ" => ["B", "A", "F", "D", "E", "C"],
    "ι" => ["B", "C", "F", "D", "E", "A"],
    "λ" => ["C", "E", "D", "B", "F", "A"],
    "ω" => ["F", "B", "D", "C", "E", "A"],
    "ϕ" => ["B", "D", "F", "C", "E", "A"],
    "τ" => ["C", "B", "F", "E", "D", "A"],
    "θ" => ["E", "D", "F", "C", "B", "A"] 
)

# Groups' date preferences
dates_prefs = Dict(
    "δ" => [1, 2, 3, 4, 5],
    "γ" => [2, 3, 1, 4, 5],
    "ι" => [1, 2, 3, 4, 5],
    "λ" => [2, 3, 4, 5, 1],
    "ω" => [2, 1, 5, 3, 4],
    "ϕ" => [3, 4, 5, 1, 2],
    "τ" => [1, 2, 3, 4, 5],
    "θ" => [1, 3, 4, 5, 2] 
)


### Functions

# Assign an option to a group given preferences
function assign_option(group, preferences, A, skip_options)
    # Skip group if already assigned
    if group in keys(A)
        return 0
    else
        for option in setdiff(get(preferences, group, 0), skip_options)
            if option in values(A)
                continue
            else
                return(option)
            end
        end
    end
end

# Random Serial Dictator algorithm
function serial_dictator(preferences, pre_assignment = nothing)
    A = Dict()
    groups = preferences |> keys |> collect |> shuffle
    println("Group order: $groups")
    # Loop through groups
    for group in groups
        # Skip options not in the previous assignment or assigned to the same group
        if !isnothing(pre_assignment)
            pre_unassigned_options = setdiff(get(preferences, group, 0), collect(values(pre_assignment)))
            skip_options = [pre_unassigned_options; get(pre_assignment, group, 0)]
        else
            skip_options = [nothing]
        end

        # Assign an option to group
        option = assign_option(group, preferences, A, skip_options)
        if option == 0
            continue
        else
            merge!(A, Dict(group => option))
        end
    end
    return(A)
end


### Compute assignments

# Filter out preferences
topic_prefs_present = filter(p -> p.first ∉ groups_presented, topic_prefs)
topic_prefs_comment = filter(p -> p.first ∉ groups_commented, topic_prefs)
dates_prefs_present = filter(p -> p.first ∉ groups_presented, dates_prefs)

# Compute assignments
selected_present = serial_dictator(topic_prefs_present)
selected_comment = serial_dictator(topic_prefs_comment, selected_present)
selected_dates = serial_dictator(dates_prefs_present)