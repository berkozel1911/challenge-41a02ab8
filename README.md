# challenge-41a02ab8

---

## Introduction
This script installs a small k3s cluster and a PostgreSQL & Redis server to that cluster.

### Installation:

- Download the package.
- Extract and cd into the directory.
- Run bash install.sh

## TODO list:

- Add firewall exceptions for k3s?
- Add done message for each script
- check the OS is Ubuntu 24.04 
- Print messages when error occurs
- Offline installation (?)
- TODO check available memory (ref: k3s installation system requirements)
- TODO check available CPU cores (ref: k3s installation system requirements)
- Make list of the error codes.
- Test Redis data write.
- Make tarball source package in GitHub Actions.