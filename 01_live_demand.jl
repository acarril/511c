### A Pluto.jl notebook ###
# v0.11.10

using Markdown
using InteractiveUtils

# ╔═╡ 558e8cd6-ed4d-11ea-3573-df3ded1e403e
md"# Constructing a demand curve

A demand curve is nothing but the total quantity the market (i.e. all of us) would buy of a good at different prices. Let's construct one now!"

# ╔═╡ c67a4320-ed4d-11ea-237a-d1fb457661d1
md"## (Our) demand for pizza

We start with a simple question:
>How many of you would buy a pizza slice if the price was \$0?

Then we keep asking:

>What if the price was $1? Or $2? Or $4? Or $8? ...

We fill the array until the quantity demanded is 0.
"

# ╔═╡ f99509b0-ed46-11ea-2cd3-773b6df84b6a
# Array of demanded quantities given prices 0, 1, 2, 4, 8, ...
q = [30, 25, 20, 10, 2, 0];

# ╔═╡ 2bd8305a-ed47-11ea-1fc6-dfafdfce9c82
# Generate array of prices starting from 0 and then following exp2().
p = [0; exp2.(0:length(q)-2)];

# ╔═╡ 4f7bf618-ed47-11ea-3994-f5a527501359
# Plot the corresponding demand curve
begin
	using Plots
	plot(q, p, label = "511c's demand for pizza slices")
	xlabel!("Quantity (of pizza slices)")
	ylabel!("Price (per pizza slice)")
end

# ╔═╡ b49adfa6-ed55-11ea-3cb2-73ec7ecfcea5
md"That's it!

When you look at a demand curve, remember it represents _total_ quantity demanded as a function of price."

# ╔═╡ d65d5724-ed53-11ea-2573-71e016c67613
md"## What about demand curves as functions?

Defining a demand curve as a continuous, smooth function such as

$$p(q) = 15 - \frac{q}{2}$$

is done basically out of convenience, and it is likely an approximation of the real demand.

**What is so convenient about them, you may ask?**

- Generalizable
- Controlled by few parameters (which can be estimated)
- Easier to manipulate algebraically 

**How good are these approximations?**

It depends.

For example, suppose I approximate our (empirical) demand for pizza slices with the demand function

$$q(p) = \frac{20}{p},$$

and then compare the approximation to the real one:"

# ╔═╡ 8b7f54e0-ed52-11ea-1d88-d9dfbe4758bb
# Define functional form for quantity 'q' as a function input 'x' (it's going to be price later)
q_fun(x) = 20/x;

# ╔═╡ 1f705464-ed51-11ea-01a3-0352ad446169
# Plot empirical demand curve (same as above) and overlay (with the '!' modifier) a plot of the approximated demand curve
begin
	plot(q, p, label = "Empirical demand")
	# Note that the 'x' axis is the result of the function we defined above, and the '.' modifier applies the function to each element of the passed array ('p')
	plot!(q_fun.(p), p, label = "Functional approximation")
end

# ╔═╡ d6eafc22-ed54-11ea-106e-551a9c389c5e
md"### Bonus question

Can you figure out why is the approximated demand curve shorter than the empirical one? (_Hint:_ it is useful to look at the code).
"

# ╔═╡ Cell order:
# ╟─558e8cd6-ed4d-11ea-3573-df3ded1e403e
# ╟─c67a4320-ed4d-11ea-237a-d1fb457661d1
# ╠═f99509b0-ed46-11ea-2cd3-773b6df84b6a
# ╠═2bd8305a-ed47-11ea-1fc6-dfafdfce9c82
# ╟─4f7bf618-ed47-11ea-3994-f5a527501359
# ╟─b49adfa6-ed55-11ea-3cb2-73ec7ecfcea5
# ╟─d65d5724-ed53-11ea-2573-71e016c67613
# ╠═8b7f54e0-ed52-11ea-1d88-d9dfbe4758bb
# ╠═1f705464-ed51-11ea-01a3-0352ad446169
# ╟─d6eafc22-ed54-11ea-106e-551a9c389c5e
