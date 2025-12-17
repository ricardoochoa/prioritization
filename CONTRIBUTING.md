# Contributing to prioritization

Thank you for your interest in contributing to **prioritization**! We welcome contributions from everyone, whether it is fixing a typo, adding a new feature, or reporting a bug.

The following is a set of guidelines for contributing to this package.

## Reporting Bugs

If you have found a bug, please [open an issue](https://github.com/ricardoochoa/prioritization/issues) on GitHub.

To help us fix the issue, please try to include a **reproducible example** (also known as a reprex). A good reprex makes it much easier for us to track down the problem. You can use the [reprex](https://reprex.tidyverse.org/) package to generate one easily.

Please include:
1. A short, self-contained code snippet that reproduces the error.
2. The error message you received.
3. Your session info (`sessionInfo()`), so we know which version of R and OS you are using.

## Suggesting Features

We welcome ideas for new features! When suggesting a feature, please:
* Check existing issues to ensure the feature hasn't already been requested.
* Explain **why** this feature would be useful (e.g., "I often need to prioritize based on X criterion...").
* If possible, describe the API or how you imagine the function call would look.

## Pull Request Process

1. **Fork** the repository to your own GitHub account.
2. **Clone** the project to your machine.
3. Create a **new branch** for your specific change (e.g., `git checkout -b fix-isochrone-bug`).
4. Make your changes.
    * If you are modifying code, please ensure you adhere to the [Tidyverse style guide](https://style.tidyverse.org/).
    * If you add new functions, please add [roxygen2](https://roxygen2.r-lib.org/) documentation comments.
5. **Test** your changes.
    * Run `devtools::test()` to ensure existing tests pass.
    * If you added a new feature, please add a corresponding test in `tests/testthat/`.
6. **Check** the package.
    * Run `devtools::check()` to ensure the package builds without errors, warnings, or notes.
7. Commit your changes with clear, descriptive commit messages.
8. Push your branch to your fork and submit a **Pull Request** to the `main` branch of `ricardoochoa/prioritization`.

## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## Questions?

If you have questions that don't fit into an issue, feel free to start a discussion in the [GitHub Discussions](https://github.com/ricardoochoa/prioritization/discussions) tab (if enabled) or contact the maintainer directly.
