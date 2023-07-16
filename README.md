# Debian Source Package Builder

**GitHub Action** for build Debian **source** package.

## Workflow Syntax

```yml
name: "Debian: Build Package"

on:
  - push

jobs:
  mirror:
    runs-on: ubuntu-latest
    name: "Build"
    steps:
      - uses: pkgstore/github-action-build-deb@main
        with:
          git_repo_src: "https://github.com/${{ github.repository }}.git"
          git_repo_dst: "https://github.com/REPO_PKG_NAME.git"
          git_user: "${{ secrets.BUILD_GIT_NAME }}"
          git_email: "${{ secrets.BUILD_GIT_EMAIL }}"
          git_token: "${{ secrets.BUILD_GIT_TOKEN }}"
          obs_user: "${{ secrets.BUILD_OBS_USER }}"
          obs_password: "${{ secrets.BUILD_OBS_PASSWORD }}"
          obs_token: "${{ secrets.BUILD_OBS_TOKEN }}"
          obs_project: "HOME:PROJECT"
          obs_package: "PKG_NAME"
```

### Legend

- `git_repo_src` - GitHub **source repository URL**.
- `git_repo_dst` - GitHub **destination repository URL**.
- `git_user` - GitHub **user**.
- `git_email` - GitHub **email**.
- `git_token` - GitHub **token**.
- `obs_user` - openSUSE Build Service **user**.
- `obs_password` - openSUSE Build Service **password**.
- `obs_token` - openSUSE Build Service **token**.
- `obs_project` - openSUSE Build Service **project**.
- `obs_package` - openSUSE Build Service **package**.

## openSUSE Build Service

### File: `_meta`

```xml
<package name="PKG_NAME" project="HOME:PROJECT">
  <title/>
  <description/>
</package>
```

### File: `_service`

```xml
<services>
  <service name="obs_scm">
    <param name="scm">git</param>
    <param name="url">https://github.com/REPO_PKG_NAME.git</param>
    <param name="revision">main</param>
    <param name="version">_none_</param>
    <param name="filename">PKG_NAME</param>
    <param name="extract">*</param>
  </service>
  <service name="tar" mode="buildtime"/>
  <service name="recompress" mode="buildtime">
    <param name="compression">xz</param>
    <param name="file">*.tar</param>
  </service>
</services>
```

### Legend

- `REPO_PKG_NAME` - repository with Debian source packages.
- `PKG_NAME` - package name.

## Example

- [ext-zsh](https://github.com/pkgstore/linux-deb-ext-zsh)
