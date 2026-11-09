# AGENTS.md

Template repo: a Jupyter Book (myst) site whose pages are Literate `.jl` "notebooks", executed one-per-job by a GitHub Actions dynamic matrix. There is no package to build and no test suite — a notebook that executes is the test.

## How it is wired

- `docs/**/*.jl` are the only notebook sources. `Literate.notebook(..., execute=true)` writes `docs/**/*.ipynb`, which `.gitignore` excludes — never edit or hand-write an `.ipynb`.
- CI globs `**/*.jl` only. A `.ipynb` dropped into `docs/` is invisible to CI, and `.github/ci.jl` just warns for non-`.jl` files (`to_literate()` is a manual helper, not part of the pipeline).
- `.github/ci.jl` is the whole execution entrypoint: reads `NB` / `NBCACHE`, executes via Literate, then `strip_svg()` drops `text/html` + `image/svg+xml` outputs whenever a PNG/JPEG exists (artifact size).
- `docs/myst.yml` is the site config. Its `toc` matches only `index.md`, `*.ipynb`, and `sub/*.ipynb`, so a **new folder under `docs/` is silently unpublished** until a `toc` entry is added. New `.bib` files likewise must be listed under `project.bibliography` or `{cite}` breaks.
- `Startup/` is a Julia workspace member (root `Project.toml` uses `[workspace]` + `[sources]`), currently a bare `PrecompileTools` warm-up stub. It is part of the CI cache key, so editing it invalidates the whole Julia depot cache.
- `Manifest.toml` is committed on purpose (static environment). Don't hand-edit it: `update-manifest.yml` regenerates it weekly and Kodiak squash-merges the `automerge`-labelled PR once CI is green.

## Commands

Use the repld skill (if available) to run Julia scripts interactively.

Execute one notebook — must run from the repo root (`NB` has no default, and Literate resolves output against `pwd()`):

```sh
NB=docs/sub/plots.jl repld julia --project=@. --color=yes .github/ci.jl
```

Produces untracked `docs/sub/plots.ipynb` plus the cached copy `.cache/docs/sub/plots.ipynb`. Literate always re-executes; `.cache` only matters to CI.

Build the site (mirrors the `render` job; needs node/npm):

```sh
npm install -g jupyter-book
cd docs && jupyter-book build --html   # -> docs/_build/html; CI sets BASE_URL=/<repo name> for the Pages subpath
```

No formatter, linter, or typecheck config exists. Link checking is lychee-only (`docs/**/*.md`, `docs/**/*.jl`) and never fails CI — it opens a "Link Checker Report" issue instead.

## Conventions

- Keep things in one function unless composable or reusable.
- Do not extract single-use helpers preemptively. Inline the logic at the call site unless the helper is reused, hides a genuinely complex boundary, or has a clear independent name that improves the caller.
- Before adding complexity for a speculative or vanishingly unlikely race or security edge case, explain the concrete failure mode, likelihood, and complexity cost to the user and get their buy-in. Do not silently expand scope for theoretical robustness.
- Notebook sources are Literate files: markdown blocks are `#===` … `===#`, code cells are separated by `#---`. `index.md` is static markdown (never executed) and feeds the site TOC alongside the built notebooks (`myst.yml`).
- **Literate gotcha:** comments inside a code cell must start with `##` (rendered as `# ` in the output). Any line starting with a single `# ` is parsed as markdown and splits the code chunk there — if that lands inside a multiline expression, Literate cuts the block in half and execution errors.
- Plots use GR; headless runs set `ENV["GKSwstype"] = "100"` (ci.jl does this for workers).
