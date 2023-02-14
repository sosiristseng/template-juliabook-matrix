# Template publishing Julia-kerneled Jupyter notebooks

Click `Use this template` button to copy this repository.

Template variants:

- [template-juliabook](https://github.com/sosiristseng/template-juliabook): using GitHub actions and dynamic matrix to execute notebooks in parallel and [jupyter-book][] to render the website.
- [template-juliabook-classic](https://github.com/sosiristseng/template-juliabook-classic): using GitHub actions and GNU `parallel` to execute notebooks and [jupyter-book][] to render the website.
- [template-juliabook-cirrus](https://github.com/sosiristseng/template-juliabook-cirrus): using [Cirrus CI][] to execute notebooks and [jupyter-book][] to render the website..
- [template-quarto-julia](https://github.com/sosiristseng/template-quarto-julia): using GitHub actions and dynamic matrix to execute notebooks in parallel and [quarto][] to rendeer the website.

[quarto]: https://quarto.org/
[jupyter-book]: https://jupyterbook.org/
[Cirrus CI]: https://cirrus-ci.org/

## GitHub actions for notebook execution

Related files:
- [ci-matrix.yml](.github/workflows/ci-matrix.yml) GitHub actions
- [Dockerfile](.github/Dockerfile) for runtime environment

When you push a change into the repository, GitHub actions will prepare the runtime environment by `julia.Dockerfile` and execute the notebooks (`*.ipynb` files in the `docs/` folder) in parallel by a job matrix. You can (and should) commit and push notebooks with empty output cells as the xecution results are generated on the fly by GitHub actions.

You need to enable GitHub actions by selecting repository settings -> actions -> general -> Actions permissions -> allow actions

## Jupyter Book and GitHub pages

[Jupyter book][jupyter-book] creates a beautiful website from Markdown and Jupyter notebook files. See [Jupyter book's website][jupyter-book] for details.

You need to enable GitHub pages by selecting repository settings -> pages -> Build and deployment -> `GitHub Actions` as the source.

## Automatic dependency updates

### Renovate and Kodiak Bot

Related files:
- [renovate.json](renovate.json)
- [.kodiak.toml](.github/.kodiak.toml)

This repository uses dependabot to automatically update Julia, Python, and GitHub actions, and [Kodiak bot](https://kodiakhq.com/) to automate dependabot's pull requests. You need to add `automerge` issue label as well as enable [Kodiak bot](https://kodiakhq.com/).

### Auto-update Julia dependencies

Related files:
- [update-manifest.yml](.github/workflows/update-manifest.yml)
- [Dockerfile](.github/Dockerfile)

GitHub acttions periodically update Julia dependencies and make a PR if the notebooks are executed successfully with the updated packages.

[See the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) for how to trigger CI workflows in a PR. This repo uses a custom [GitHub APP](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#authenticating-with-github-app-generated-tokens) to generate a temporary token.

### Checking links

Related files:
- [linkcheck.yml](.github/workflows/update-manifest.yml)

GitHub actions regularly check if the links are valid.

## Binder docker images

Related files:
- [binder.yml](.github/workflows/binder.yml) GitHub action

Environment files:
- [apt.txt](apt.txt) for apt-installed dependencies.
- [requirements.txt](requirements.txt) for Python/conda dependencies and [runtime.txt](runtime.txt) for Python version.
- [Project.toml](Project.toml), [Manifest.toml](Manifest.toml), and the [src](src/) folder for Julia dependencies.

This GitHub action builds docker images to run notebooks online on [mybinder](https://mybinder.org/) using [repo2docker](https://repo2docker.readthedocs.io/) and pushs the resulting container to [GitHub container registry (GHCR)][ghcr]. The [.binder/Dockerfile](.binder/Dockerfile) that points to the container will be auto generated.

[ghcr]: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
