#!/bin/bash

INPUT_FOLDER="${1:-}"
OUTPUT_FOLDER="${2:-}"
NUM_DESIGNS="${3:-500}"

BG_SLURM_SCRIPT="/n/home06/tbush/peptide_gen_pipeline/installation_scripts/bg_1st_run.slrm"
BC_SLURM_SCRIPT=""
#create specific output folders:
BG_OUTPUT_FOLDER="${OUTPUT_FOLDER}/bg/"
BC_OUTPUT_FOLDER="${OUTPUT_FOLDER}/bc/"

BG_INPUT_FILE="${INPUT_FOLDER}/design_config.yaml"
BC_INPUT_FILE="${INPUT_FOLDER}/design_config.json"

mkdir -p "${BG_OUTPUT_FOLDER}"
mkdir -p "${BC_OUTPUT_FOLDER}"

echo "Launching Boltz Gen Predictions:"
sbatch "${BG_SLURM_SCRIPT}" "${BG_INPUT_FILE}" "${BG_OUTPUT_FOLDER}" "{$NUM_DESIGNS}"
