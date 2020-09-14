using Random
Random.seed!(09142020)
Groups = [
    "Blue",
    "Green",
    "Magenta",
    "Maroon",
    "Red",
    "Purple",
    "Orange",
    "Yellow"
]
chosen = Groups[rand(1:length(Groups))]
println("Chosen one is $(chosen)!")
