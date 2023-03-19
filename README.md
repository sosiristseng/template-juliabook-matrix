# Template publishing Julia-kerneled Jupyter notebooks

Click `Use this template` button to copy this repository.

See also:

- [template-quarto-julia](https://github.com/sosiristseng/template-quarto-julia): using GitHub actions and dynamic matrix to execute notebooks in parallel and [quarto][] to rendeer the website.

[quarto]: https://quarto.org/
[jupyter-book]: https://jupyterbook.org/
[Cirrus CI]: https://cirrus-ci.org/

## GitHub actions for notebook execution

See:

- [ci-matrix.yml](.github/workflows/ci-matrix.yml) GitHub actions
- [Dockerfile](.github/Dockerfile) for runtime environment
- [requirements.txt](requirements.txt) in root folder for Python dependencies

When you push a change into the repository, GitHub actions will prepare the runtime environment by `Dockerfile` and execute the notebooks (`*.ipynb` files in the `docs/` folder) in parallel by a job matrix. You can (and should) commit and push notebooks with empty output cells as execution results will be populated by GitHub actions.

## Jupyter Book and GitHub pages

[Jupyter book][jupyter-book] creates a beautiful website from Markdown and Jupyter notebook files.

You need to enable GitHub pages by selecting repository settings -> pages -> Build and deployment -> `GitHub Actions` as the source.

## Automatic dependency updates

### Renovate bot and Kodiak Bot

- [renovate.json](renovate.json)
- [.kodiak.toml](.github/.kodiak.toml)

This repository uses [Renovate Bot](https://github.com/marketplace/renovate) to automatically update Julia, Python, and GitHub actions, and [Kodiak bot](https://kodiakhq.com/) to automate pull requests.

One needs to enable both bots and adds `automerge` as an issue label for them to work properly.

### Julia dependencies

- [update-manifest.yml](.github/workflows/update-manifest.yml)
- [Dockerfile](.github/Dockerfile)

The GitHub acttion will periodically update Julia dependencies and make a PR if the notebooks are executed successfully with the updated packages.

See also [the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) for how to trigger CI workflows in a PR. This repo uses a custom [GitHub APP](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#authenticating-with-github-app-generated-tokens) to generate a temporary token.

## Checking links in markdown files and notebooks

- [linkcheck.yml](.github/workflows/linkcheck.yml)

GitHub actions regularly check if the links are valid.

## Binder docker images

- [binder.yml](.github/workflows/binder.yml) GitHub action

Binder runtime environment files:

- [apt.txt](apt.txt) for apt-installed dependencies.
- [requirements.txt](requirements.txt) for Python/conda dependencies and [runtime.txt](runtime.txt) for Python version.
- [Project.toml](Project.toml), [Manifest.toml](Manifest.toml), and (optionally) the [src](src/) folder for Julia dependencies.

This GitHub action builds docker images to run notebooks online on [mybinder](https://mybinder.org/) using [repo2docker](https://repo2docker.readthedocs.io/) and pushes the resulting container to [GitHub container registry (GHCR)][ghcr]. The action also generates [.binder/Dockerfile](.binder/Dockerfile) that points to the container.

[ghcr]: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
