<h1 align="center">essentia-docker</h1>

*<p align="center">Docker images for the Essentia audio analysis library</p>*

<p align="center">
  <a href="https://github.com/lagmoellertim/essentia-docker/actions/workflows/build.yml" target="_blank"><img src="https://github.com/lagmoellertim/essentia-docker/actions/workflows/build.yml/badge.svg" alt="Build Status"/></a>
  <a href="https://github.com/lagmoellertim/essentia-docker/blob/main/LICENSE" target="_blank"><img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="MIT License Badge"/></a>
</p>

---

## Introduction

Welcome to **essentia-docker**, a collection of Docker images for [Essentia](https://essentia.upf.edu/), the open-source C++ library for audio and music analysis, description, and audio-based music information retrieval. This project provides multi-platform Docker images for Essentia, including optional builds with TensorFlow and GPU support. These images are intended as a base for your own development or integration work, rather than as ready-to-use applications.

## Features

- **Multi-Platform**: Images for `amd64` and `arm64` architectures
- **TensorFlow Support**: Optional builds with TensorFlow (CPU/GPU)
- **Easy Deployment**: Run Essentia in a containerized environment with minimal setup
- **CI/CD**: Automated builds and multi-arch manifests via GitHub Actions

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system

### Pulling from Docker Hub

Images are published to Docker Hub under `lagmoellertim/essentia`.

```bash
docker pull docker.io/lagmoellertim/essentia:latest
```

### Available Tags

- `latest` – Standard Essentia build
- `-tensorflow` – With TensorFlow (CPU)
- `-tensorflow-gpu` – With TensorFlow (GPU)

### Running Essentia

> **Note:** These images are not meant to be run directly as containers. They include all Essentia headers and shared libraries (`.so` files) so you can use them as a base for your own images or for development purposes.

If you want to use Essentia in your own Docker image, use this as a base:

```dockerfile
FROM lagmoellertim/essentia:latest
# ...your build steps...
```

## Building Locally

To build the images yourself:

```bash
git clone https://github.com/lagmoellertim/essentia-docker.git
cd essentia-docker
docker build -t essentia:latest .
```

For TensorFlow builds:

```bash
docker build -t essentia:tensorflow --build-arg ENABLE_TENSORFLOW=1 --build-arg TENSORFLOW_USE_GPU=0 .
```

## Contributing

Feel free to open issues or submit pull requests for improvements, new features, or bug fixes!

## Author

**Tim-Luca Lagmöller** ([@lagmoellertim](https://github.com/lagmoellertim))

## Donations / Sponsors

I'm part of the official GitHub Sponsors program where you can support me on a monthly basis.

<a href="https://github.com/sponsors/lagmoellertim" target="_blank"><img src="https://github.com/lagmoellertim/shared-repo-files/raw/main/github-sponsors-button.png" alt="GitHub Sponsors" height="35px" ></a>

You can also contribute by buying me a coffee (this is a one-time donation).

<a href="https://ko-fi.com/lagmoellertim" target="_blank"><img src="https://github.com/lagmoellertim/shared-repo-files/raw/main/kofi-sponsors-button.png" alt="Ko-Fi Sponsors" height="35px" ></a>

Thank you for your support!

## License

The Code is licensed under the

[MIT License](https://github.com/lagmoellertim/essentia-docker/blob/main/LICENSE)

Copyright © 2025-present, [Tim-Luca Lagmöller](https://lagmoellertim.de)

## Have fun :tada:
