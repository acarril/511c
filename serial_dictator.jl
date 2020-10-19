### Libraries
using Random
Random.seed!(511)


### Data

# Groups which already presented/commented
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

# Assign one unassigned group to one unassigned preference
function assign_group(group, preferences, A_old, skip_topic = nothing)
    # Skip group if already assigned
    if group in keys(A_old)
        return -1
    else
        for topic in setdiff(get(preferences, group, 0), [skip_topic])
            if topic in values(A_old)
                continue
            else
                return(topic)
            end
        end
    end
end

# Random Serial Dictator
function serial_dictator(preferences, pre_assignmnent = nothing)
    A = Dict()
    groups = preferences |> keys |> collect |> shuffle
    println("Group shuffle is $groups")
    
    for group in groups
        # Skip any pre-assigned preference
        if !isnothing(pre_assignmnent)
            skip_topic = get(pre_assignmnent, group, nothing)
        else
            skip_topic = nothing
        end

        # Assign topic to group
        topic = assign_group(group, preferences, A, skip_topic)
        if topic == -1
            continue
        else
            merge!(A, Dict(group => topic))
        end
    end
    return(A)
end


### Compute assignments

# Filter out preferences
topic_prefs_present = filter(p -> p.first ∉ groups_presented, topic_prefs)
topic_prefs_comment = filter(p -> p.first ∉ groups_commented, topic_prefs)
dates_prefs_present = filter(p -> p.first ∉ groups_presented, dates_prefs)

# Compute groups
selected_present = serial_dictator(topic_prefs_present)
selected_comment = serial_dictator(topic_prefs_comment, selected_present)
selected_dates = serial_dictator(dates_prefs_present)