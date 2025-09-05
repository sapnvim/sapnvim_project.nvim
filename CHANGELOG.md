# Changelog

## [1.1.1](https://github.com/sapnvim/sapnvim_project.nvim/compare/v1.1.0...v1.1.1) (2025-09-05)


### Bug Fixes

* **autocmds:** defer execution of create_aotucmd ([fcfcac8](https://github.com/sapnvim/sapnvim_project.nvim/commit/fcfcac815560931713911289b4c5bb16cf4aa86f))

## [1.1.0](https://github.com/sapnvim/sapnvim_project.nvim/compare/v1.0.0...v1.1.0) (2025-03-04)


### Features

* **autocmd:** implement auto session restore feature ([9aea10b](https://github.com/sapnvim/sapnvim_project.nvim/commit/9aea10b7e60e02a6c06e4281681980609d7311c3))


### Bug Fixes

* **project:** ensure existing projects are saved to history when closed ([846225f](https://github.com/sapnvim/sapnvim_project.nvim/commit/846225f629a7b16a1e4d99983f6ba2dd3aecf2ad))

## 1.0.0 (2025-03-03)


### Features

* **autocmds:** add automatic session saving on neovim exit ([f9cc61d](https://github.com/sapnvim/sapnvim_project.nvim/commit/f9cc61d47db25eea716494ca420fd80bf3fede6c)), closes [#1](https://github.com/sapnvim/sapnvim_project.nvim/issues/1)
* **config:** Add custom sessionoptions to defaults ([4c62a54](https://github.com/sapnvim/sapnvim_project.nvim/commit/4c62a54500e272fef7b4d25c1754f559679562aa))
* **project:** Add new picker "fzf-lua" ([498d6ec](https://github.com/sapnvim/sapnvim_project.nvim/commit/498d6ec0f0875d3fd1091dd3d6f361c9963408f3))
* **project:** add new ProjectSave command ([782b65c](https://github.com/sapnvim/sapnvim_project.nvim/commit/782b65c49ef2dd305af297d49a7ca21100bc9ea8))
* **project:** add ProjectSwitch and ProjectAdd commands ([4c3505d](https://github.com/sapnvim/sapnvim_project.nvim/commit/4c3505db92c0a6f070ea37363c5798a05758cbb8))
* **project:** Added ProjectCloases command to close the current project and save the latest status before closing. ([6439416](https://github.com/sapnvim/sapnvim_project.nvim/commit/64394165c38a79445e24f7ec1ada0a21c0fe9c5a))
* **project:** Save Project History When Using ProjectClose Command ([65908b1](https://github.com/sapnvim/sapnvim_project.nvim/commit/65908b15eff8ea877fbcde709ce5199eae76dfa2)), closes [#4](https://github.com/sapnvim/sapnvim_project.nvim/issues/4)
* **project:** Save project history when using ProjectLoad command ([e1d077e](https://github.com/sapnvim/sapnvim_project.nvim/commit/e1d077e966dc0b278d8603f870370ca5f2411720)), closes [#5](https://github.com/sapnvim/sapnvim_project.nvim/issues/5)


### Bug Fixes

* Fixed the error that user configuration cannot overwrite default configuration. ([69a7ec7](https://github.com/sapnvim/sapnvim_project.nvim/commit/69a7ec738a31e0b14660c9619490b4b33fcfdec6))
* **project:** Fixed a bug where the ProjectLoad command would not write existing projects to history ([2f1fa87](https://github.com/sapnvim/sapnvim_project.nvim/commit/2f1fa87327fc76a68768a7c39a61cbe8b6e6a99a)), closes [#1](https://github.com/sapnvim/sapnvim_project.nvim/issues/1)
* **project:** Fixed the bug that ProjectAdd command does not create projects and delete projects ([b3bd734](https://github.com/sapnvim/sapnvim_project.nvim/commit/b3bd73421558fc30557175589a5411173bc15a51))
* **session_manager:** Fixed the issue that an error message would be displayed when selecting a project item with an invalid path when using the ProjectSwitch command ([a1ceaaa](https://github.com/sapnvim/sapnvim_project.nvim/commit/a1ceaaab2ae2a94480b16a6dc5ab47cbe540f4c8))
* **session_manager:** Improve session parameter validation ([af01904](https://github.com/sapnvim/sapnvim_project.nvim/commit/af019040b3e6cb5ce685722c337ff58cba491fcf))
