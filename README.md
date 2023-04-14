# Template publishing Julia-kerneled Jupyter notebooks

[Jupyter book][jupyter-book] creates a beautiful website from Markdown and Jupyter notebook files. It is done by my [docker-jupyterbook](https://github.com/sosiristseng/docker-jupyterbook) container.

Click `Use this template` button to copy this repository.

See also:

- [template-quarto-julia](https://github.com/sosiristseng/template-quarto-julia): using GitHub actions and dynamic matrix to execute notebooks in parallel and [quarto][] to rendeer the website.

[quarto]: https://quarto.org/
[jupyter-book]: https://jupyterbook.org/
[Cirrus CI]: https://cirrus-ci.org/

## Notebook execution and publish

You will need one of "GitHub actions" and "Cirrus CI".

### GitHub actions

- Workflow file: [ci.yml](.github/workflows/ci.yml)

### Cirrus CI for notebook execution and publish

[Cirrus CI](https://cirrus-ci.org/) workflow files:

- [.cirrus.yml](.cirrus.yml) for Cirrus CI pipelines
- [cirrus-notify.yml](.github/workflows/cirrus-notify.yml) for notification in GitHub in case of execution error
- [Dockerfile](cirrus.Dockerfile) for runtime environment

You'll need a repo scope GitHub token (click [here](https://github.com/settings/tokens/new?scopes=repo)) [encrypted](https://cirrus-ci.org/guide/writing-tasks/#encrypted-variables) in cirrus CI. Use the encrypted value as `GH_TOKEN` variable to push the `gh-pages` branch back to GitHub.

### Jupyter Book

[Jupyter book][jupyter-book] creates a beautiful website from Markdown and Jupyter notebook files. It is done by my [docker-jupyterbook](https://github.com/sosiristseng/docker-jupyterbook) container.

## Enable GitHub pages

Open your repository settings => Pages => GitHub Pages
=> Build and deployment => Source, select the `gh-pages` branch.

## Automatic dependency updates

### Renovate bot and Kodiak Bot

- [renovate.json](renovate.json)
- [.kodiak.toml](.github/.kodiak.toml)

This repository uses [Renovate Bot](https://github.com/marketplace/renovate) to automatically update Julia, Python, and GitHub actions, and [Kodiak bot](https://kodiakhq.com/) to automate pull requests.

One needs to enable both bots and adds `automerge` as an issue label for them to work properly.

### Julia dependencies

- [update-manifest.yml](.github/workflows/update-manifest.yml) workflow file

The GitHub acttion will periodically update Julia dependencies and make a PR if the notebooks are executed successfully with the updated packages.

See also [the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) for how to trigger CI workflows in a PR. This repo uses a custom [GitHub APP](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#authenticating-with-github-app-generated-tokens) to generate a temporary token.

## Checking links in markdown files and notebooks

- [linkcheck.yml](.github/workflows/linkcheck.yml)

GitHub actions regularly check if the links ihn the notebooks are valid.

## Binder docker images

- [binder.yml](.github/workflows/binder.yml) workflow file

Binder runtime environment files:

- [apt.txt](apt.txt) (Optional) for apt-installed dependencies.
- [requirements.txt](requirements.txt) for Python dependencies and [runtime.txt](runtime.txt) for Python version.
- [Project.toml](Project.toml), [Manifest.toml](Manifest.toml), and the [src](src/) folder for Julia dependencies.

This GitHub action builds docker images to run notebooks online on [mybinder](https://mybinder.org/) using [repo2docker](https://repo2docker.readthedocs.io/) and pushes the resulting container to [GitHub container registry (GHCR)][ghcr]. The action also generates [.binder/Dockerfile](.binder/Dockerfile) that points to the container.

[ghcr]: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
