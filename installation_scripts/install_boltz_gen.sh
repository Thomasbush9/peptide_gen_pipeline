#!/bin/bash
# create a cache dir just for boltz gen:
module purge
module load python/3.12.8-fasrc01 gcc/14.2.0-fasrc01
echo "Creating new pythong env"
mamba create -n bg python=3.12

echo "Downloading boltz directory"
mamba activate bg
pip install boltzgen

echo "boltz is correctly installed"

mamba deactivate
module purge
