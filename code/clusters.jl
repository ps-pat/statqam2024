using Moosh

using Random: Xoshiro

using Distributions

using Plots

using LaTeXStrings

using ColorSchemes

using Clustering, StatsPlots

n = 750
m = 8

rng = Xoshiro(1)
H = sort([Sequence(rng, m) for _ ∈ 1:n], by = Base.bitcount)
for k ∈ eachindex(H)
    H[k][2] = rand(rng) ≤ 0.1
    H[k][4] = rand(rng) ≤ 0.2
    H[k][6] = rand(rng) ≤ 0.1
end
Φ = rand(rng, n) .≤ 0.9((getindex.(H, 2) + getindex.(H, 4) + getindex.(H, 6)) .% 2)

tree = Tree(H, positions = range(0, 1, length = m))
build!(rng, tree)

arg = Arg(tree)
@time build!(rng, arg, winwidth = Inf)

thmat = thevenin_matrix(arg)

hcl = hclust(thmat, linkage = :complete, branchorder = :optimal)

Φcolors = (cgrad ∘ ColorScheme)([colorant"#ffffff", colorant"#e65100"])
Hcolors = (cgrad ∘ ColorScheme)([colorant"#ffffff", colorant"#9558b2"])
p = plot(plot(hcl, xgrid = false),
         heatmap(Φ[hcl.order]', colorbar = false, yticks = false,
                 c = Φcolors),
         heatmap(hcat(getfield.(H[hcl.order], :data)...),
                 colorbar=false, yticks = false, c = Hcolors),
         layout = StatsPlots.grid(3, 1, heights = [0.85, 0.05, 0.1]),
         legend = false,
         xticks = false,
         link = :x)

savefig(p, "../assets/clusters.html")
