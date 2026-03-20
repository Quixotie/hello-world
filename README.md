# Karamullane Author Mirror

This repository contains a static mirror of https://www.karamullaneauthor.com/ prepared for GitHub Pages hosting.

## Structure

- `index.html` is the homepage.
- Top-level sections use folder routes such as `books/`, `about/`, `emmisworld/`, and `resources/`.
- Deeper mirrored pages also use folder routes with their own `index.html` files.
- Shared Wix runtime assets are stored in root-level folders such as `media/`, `services/`, `unpkg/`, `onsite/`, and `tag-bundler/`.

## Local Preview

If you want to preview the site locally from the repository root, you can serve the parent directory so the site is loaded from a repository-style subpath:

```sh
cd /Users/erikrhodes/repos
python3 -m http.server 8000
```

Then open:

- `http://127.0.0.1:8000/hello-world/`

That matches the path shape GitHub Pages will use for a project site.

## GitHub Pages Deployment

This repo includes:

- `.nojekyll` so folders that begin with underscores are not processed by Jekyll
- `.github/workflows/deploy-pages.yml` to deploy the repository to GitHub Pages on pushes to `main`

To enable deployment in GitHub:

1. Push the repository to GitHub.
2. In the repository settings, open Pages.
3. Set the source to GitHub Actions.
4. Push to `main` to trigger deployment.

The published URL should be in the form:

- `https://<your-user-name>.github.io/hello-world/`