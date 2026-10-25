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

Execute one notebook — must run from the repo root (`NB` has no default, and Literate resolves output against `pwd()`):

```sh
NB=docs/sub/plots.jl julia --project=@. --color=yes .github/ci.jl
```

Produces untracked `docs/sub/plots.ipynb` plus the cached copy `.cache/docs/sub/plots.ipynb`. Literate always re-executes; `.cache` only matters to CI.

Build the site (mirrors the `render` job; needs node/npm):

```sh
npm install -g jupyter-book
cd docs && jupyter-book build --html   # -> docs/_build/html; CI sets BASE_URL=/<repo name> for the Pages subpath
```

No formatter, linter, or typecheck config exists. Link checking is lychee-only (`docs/**/*.md`, `docs/**/*.jl`) and never fails CI — it opens a "Link Checker Report" issue instead.

## CI gotchas

- Julia version comes from `julia_version` in `Manifest.toml`, **not** from `[compat] julia` in `Project.toml`; bumping Julia means regenerating the Manifest.
- Per-notebook cache key is `notebook-<hash(Project.toml,Manifest.toml,Startup/**)>-<hash(notebook)>`: touching deps re-runs every notebook, touching one `.jl` re-runs one job. Bump `CACHE_NUM` in `.github/workflows/ci.yml` to force a full re-run when the depot cache goes stale; `clear-cache.yml` deletes a merged PR's caches automatically and nukes everything on `workflow_dispatch`.
- Only the `setup` job saves `~/.julia`; `execute` jobs restore it read-only.
- `PythonPlot` needs the CondaPkg env `@mpl` for matplotlib (`JULIA_CONDAPKG_ENV=@mpl`) and GR needs `GKSwstype=100` — export both to reproduce a plotting failure locally.
- Jobs run on `ubuntu-26.04-arm`; `JULIA_CPU_TARGET=sysimage` is set only on x64 GitHub-hosted runners so cached precompiles stay portable.
- `execute` uses `fail-fast: false`, so read which notebook failed, not just the run status. `deploy` runs only on `main`, and repo Pages must use the "GitHub Actions" source (see README).

## Conventions

- Literate markup: `#=== ... ===#` markdown blocks, `#---` cell separators, `# ## Heading` for headings (`mdstrings=true` is enabled, so `md""" ... """` works as a markdown block too).
- **Comments inside code blocks start with `##`, not `#`.** Literate parses any single-`#` line as markdown prose and reserves `##` for Julia code comments, so `# foo` silently becomes body text while `## foo` stays a comment.
- Every sample notebook ends with `Pkg.status()` and `InteractiveUtils.versioninfo()` cells — keep that in new notebooks.
- Indentation follows `.editorconfig`: 4 spaces for `.jl`, 2 spaces for `.yml`/`.md`/`.toml`.
- Dependabot covers GitHub Actions only (the `pip` and `julia` ecosystems are deliberately commented out in `.github/dependabot.yml`); Julia deps belong to `update-manifest.yml`.
- Kodiak config is at `.github/.kodiak.toml` (the README's `.kodiak.toml` path is stale).
