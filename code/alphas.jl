using Moosh

using Random: Xoshiro

using Distributions

using Plots

using LaTeXStrings

using ColorSchemes

rng = Xoshiro(42)

n = 1000
m = 1

H = sort([Sequence(rng, m) for _ ∈ 1:n], by = Base.bitcount)

fG = CoalMutDensity(n, 1000, 1e-2, 1, [0.])

rrs = 1:2:10
As = Vector{AlphaExponential}(undef, length(rrs))
for (i, rr) ∈ enumerate(rrs)
    Φ = fill(false, n)
    for (j, η) ∈ enumerate(H)
        rand(rng) ≤ (1 + first(η) * rr) / 10 || continue
        Φ[j] = true
    end
    p = sum(Φ) / n
    @show p

    As[i] = AlphaExponential()
    frechet = CopulaFrechet(Bernoulli(p), As[i])

    fit!(rng, frechet, Φ, H, Tree; n = 10, genpars(fG)...)
end

cs = ColorScheme(range(colorant"#030000", colorant"#e65100", length = length(rrs)))

x = range(0, 5, length = 100)
p = plot(x, As[1].(x), label = L"RR = 2",
         xlabel = L"t",
         ylabel = L"\alpha(t)",
         palette = cs,
         linewidth = 5,
         guidefontsize = 20,
         tickfontsize = 10,
         legendfontsize = 15)

for (k, A) ∈ enumerate(Iterators.rest(As, 2))
    rr = 2(k + 1)
    plot!(p, x, A.(x),
          label = L"RR = %$rr",
          linewidth = 5)
end

savefig(p, "../assets/alphas.svg")
