#!/bin/bash
set -euo pipefail

INSTALL_FOLDER="${1:-}"
CUDA_VERSION=12.9
PKG_MANAGER="mamba"
if [[ -z "${INSTALL_FOLDER}" ]]; then
  echo "You must specify an install folder to install BindCraft"
  exit 1
fi

git clone https://github.com/martinpacesa/BindCraft "${INSTALL_FOLDER}"

cd "${INSTALL_FOLDER}"

module purge

module load python/3.12.8-fasrc01 gcc/14.2.0-fasrc01 cuda/12.9.1-fasrc01 cudnn/9.10.2.21_cuda12-fasrc01
echo "Creating bindcraft Env"
mamba create -n bindcraft python=3.12.8
mamba activate bindcraft
echo "Installing bindcraft in ${INSTALL_FOLDER}"
bash install_bindcraft.sh --cuda "${CUDA_VERSION}" --pkg_manager "${PKG_MANAGER}"
