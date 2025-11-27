# Template for publishing Julia Jupyter notebooks with dynamic matrix

Click `Use this template` button to copy this repository.

Publish Julia notebooks using [Jupyter Book](https://jupyterbook.org/stable/).
- Supports both [Literate](https://github.com/fredrikekre/Literate.jl) (`*.jl`) and Jupyter (`*.ipynb`) notebooks. Jupyter notebooks will be converted to the Literate format before execution.
- Uses dynamic matrix and runs notebooks in parallel in GitHub actions. See `ci.yml`.
- Automatic dependency updates by dependabot and `update-manifest.yml` GitHub actions.
- Checks if the links in the notebooks are valid with `lychee`. (See `linkcheck.yml`)

See also:

- https://github.com/sosiristseng/template-juliabook : Using  multiprocessing to run Literate notebooks in parallel. Jupyter Book builds the website.
- https://github.com/sosiristseng/template-juliabook-matrix : Using the dynamic parallel matrix to run Literate notebooks in parallel. Jupyter Book builds the website.
- https://github.com/sosiristseng/template-quarto-literate : Using multiprocessing to run Literate notebooks in parallel. Quarto builds the website.
- https://github.com/sosiristseng/template-quarto-julia-matrix : Using the dynamic parallel matrix to run Literate notebooks in parallel. Quarto builds the website.
- https://github.com/sosiristseng/template-quarto-julia : Using Quarto to run and render Quarto notebooks (`*qmd`).


## You need to enable GitHub pages

From your repository settings => Pages => GitHub Pages => Build and deployment => Source, select `GitHub actions`.

## Automatic dependency updates

See `.kodiak.toml` and `dependabot.yml`.

This repository uses [Dependabot](https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide) and [Kodiak Bot](https://kodiakhq.com/docs/quickstart) to automatically merge Python and GitHub actions updates.

### Julia dependencies

See `update-manifest.yml`.

This repository can regularly update Julia in the `Manifest.toml`, make a PR with the updated packages, and automatically merge the updates if the notebooks are executed without any problem.

See [the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) for how to trigger CI workflows in a PR. This repo uses my [GitHub APP](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#authenticating-with-github-app-generated-tokens) to generate a token on the fly.
