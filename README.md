# Git Tools

Git Tools is a collection of shell commands made to streamline my personal Git workflow. The tools are tailored to my pseronal directory structure and workflow for managing multiple Git hosts and projects efficiently and consistently. These tools aim to make repetitive tasks - like cloning repositories and committing/pushing changes - quicker and less hard on your precious fingers.

There directory struture and workflow are designed for working with multiple Git hosts (e.g. GitHub, GitLab, private servers) while maintaining a consistent organization across projects.

#### Why Git Tools?

Managing projects from multiple Git hosts or Organizations can quickly become messy and tedious. This repo aims to standardize this process by:

- Automatically organizing repositories into a predictable directory structure based on their Git URLs
- Reducing the number of commands required for frequent Git operations (e.g. cloning, adding, committing, pushing)
- Ensuring that navigating between projects is fast and seamless.

These rools are built specifically for my workflow and directory structure. While you're welcome to adapt them to your own use, they may not work well with other workflows without modification.

## Directory Structure

All repositories are stored under a single base directory: `~/git`.

Within this directory, repositories are organized by the Git host, user/organization, and repository name. This structure mirrors the repository's URL, ensuring consistency and making it easy to locate projects.

**Examples:**

1. GitHub Repositories:
    - URL: `https://github.com/hashicorp/terraform.git`<br>
      Path: `~/git/github.com/hashicorp/terraform`
    - URL: `git@github.com/opentofu/opentofu.git`<br>
      Path: `~/git/github.com/opentofu/opentofu`

1. GitLab Repositories:
    - URL: `https://gitlab.com/gnachman/iterm2.git`<br>
      Path: `~/git/gitlab.com/gnachman/iterm2`
    - URL: `git@gitlab.com:wireshark/wireshark.git`<br>
      Path: `~/git/gitlab.com/wireshark/wireshark`

1. Private Git Servers:
    - URL: `git@myserver.net/me/my-proj`<br>
      Path: `~/git/myserver.net/me/my-proj`

## Installation

WIP

## Command Reference

All commands are prefixed with the operator `g`. For example, the clone/navigate command `c` is run with `g c`.

### c (clone / navigate)

Clones a repo to the correct directory structure and navigates you to the newly cloned repo. If this repo already exists in your path, you will just be navigated to the repo.

Usage:
```bash
g c <SSH/HTTPS URL>
```

Example:
```bash
g c git@github.com/opentofu/opentofu.git
```

### acp (add + commit + push)

Runs the classic series of commands we've all typed countless times to add your changes from the current directory, create a commit, and push up your commit to the current branch. `acp` is different from `acpa` in that it only adds changes downstream from your current directory:

- `git add .`
- `git commit -m <commit message>`
- `git push origin <current branch>`

Usage:
```bash
g acp <commit message>
```

Example:
```bash
g acp "fix: bug when accessing site from a youtube redirect"
```

### acpa (add + commit + push (all))

Runs the classic series of commands we've all typed countless times to add all of your current changes, create a commit, and push up your commit to the current branch. `acpa` is different from `acp` in that it adds **all** your changes by `cd`ing into the project root before running:

- `cd <project root>`
- `git add .`
- `git commit -m <commit message>`
- `git push origin <current branch>`

Usage:
```bash
g acpa <commit message>
```

Example:
```bash
g acpa "fix: bug when accessing site from a youtube redirect"
```

### o (open)

Opens the current repo in your browser. Grabs and formats the URL from `git remote get-url origin`.

Usage:
```bash
g o
```

### m (create merge/pull request)

Generates a URL to open in your browser to create a Merge / Pull Request (depending on platform) from your current branch. If no target branch is provided, it will target the default branch. Currently supports GitHub & GitLab and assumes all alternative selfhosted URLs are powered by GitLab.

Usage:
```bash
g m <target branch>
```

Example:
```bash
g m dev
```