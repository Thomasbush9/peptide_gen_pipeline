#!/bin/bash

set -e
set -x

INPUT="/n/home06/tbush/peptide_gen_pipeline/installation_scripts/examples/gfp_design.yaml"
OUTPUT_DIR="/n/home06/tbush/outputs/boltz_gen/"
BOLTZ_GEN_SCRIPT=/n/home06/tbush/peptide_gen_pipeline/installation_scripts/bg_1st_run.slrm"
NUM_DESIGNS=${1:-1000}
mkdir -p "${OUTPUT_DIR}"



echo "Launch Boltz Generation"
sbatch "${BOLTZ_GEN_SCRIPT}"

