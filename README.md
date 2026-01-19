# challenge-41a02ab8

---

## Introduction
This script installs a small k3s cluster and a PostgreSQL & Redis server to that cluster.

### Notes:
- Attention! Do not manually edit values of variables in yml files at `vars/` directory starting with `CHANGE_`. These are special values like placeholders, will be changed by sed commands in `install.sh`. If you want to change these values, edit the values explained in `env.sh`. The `sed` commands in `install.sh` will change placeholders in `vars/*.yml`. Because same variables and values both used by Helm configuration files and Bash scripts, this is needed for change the values from one location if any configuration needed.

- This script is only tested on Ubuntu 24.04 server. It may work on other Ubuntu versions, but not tested yet.

### Workflow of the project:
- `env.sh` contains values of configuration values.
- `install.sh` will grab those values and passes to Helm yml files under `vars/`, changes placeholders starting with `CHANGE_` keyword.
- `install.sh` will run `install_k3s.sh`, `install_helm.sh`, `install_pgsql.sh`, `install_redis.sh` in that order.
- Then `install.sh` will call `install_cronjob.sh` to install PostgreSQL periodic backup job.
- After all of the installation scripts are finished, `install.sh` will wait for 60 seconds to make sure pods are up, then calls the test scripts under `tests/`, in the order of `test_utils.sh`, `test_pgsql.sh`, `test_redis.sh`.
- These subscripts can take arguments passed from `install.sh` or use variables defined in `env.sh`, since `env.sh` is sourced by `install.sh`, then passed to subscripts.

### Simple CI implementation:
- The instructions in `.github/workflows/release-tarball.yml` makes GitHub Actions to create a simple tarball package named `release-latest.tar.gz` from master branch when triggered.

### Installation:

- Grab the latest release from Releases.
- Extract and cd into the directory.
- Make your configurations in `env.sh`
- Run `bash install.sh`


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