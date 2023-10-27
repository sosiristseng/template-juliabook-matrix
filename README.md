# Template publishing Julia-kerneled Jupyter notebooks

Click `Use this template` button to copy this repository.

See also:

- [template-quarto-julia](https://github.com/sosiristseng/template-quarto-julia): using GitHub actions and dynamic matrix to execute notebooks in parallel and [quarto][] to rendeer the website.

[quarto]: https://quarto.org/
[jupyter-book]: https://jupyterbook.org/
[Cirrus CI]: https://cirrus-ci.org/

## Notebook execution and publish via continuous integration (CI)

- Workflow file: [ci.yml](.github/workflows/ci.yml)

The notebooks (under the `docs` folder) are executed in parallel, and then [Jupyter book][jupyter-book] creates a beautiful website from Markdown and Jupyter notebook files.

## Enable GitHub pages

Open your repository settings => Pages => GitHub Pages => Build and deployment => Source, select `GitHub actions`.

## Automatic dependency updates

### Renovate bot and Kodiak Bot

- See [renovate.json](renovate.json) for Renovate settings.

This repository uses [Renovate Bot](https://github.com/marketplace/renovate) to automatically update Julia packages, Python packages, and GitHub actions.

### Julia dependencies

The Github workflow [update-manifest.yml](.github/workflows/update-manifest.yml) will regularly update Julia dependencies, make a PR with the updated packages, and automatically merge (by [Kodiak bot](https://kodiakhq.com/)) the updates if the notebooks are executed without error.

See [the instructions](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs) for how to trigger CI workflows in a PR. My repo uses a custom [GitHub APP](https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#authenticating-with-github-app-generated-tokens) to generate a token on the fly.

## Checking HTTP links

GitHub actions by [linkcheck.yml](.github/workflows/linkcheck.yml) regularly check if the web links in the notebooks are valid.
