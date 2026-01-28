#!/bin/bash
set -euo pipefail

# -------------------------
# Args with defaults
# -------------------------
INPUT_FOLDER="${1:-}"
OUTPUT_FOLDER="${2:-}"
NUM_DESIGNS="${3:-500}"

if [[ -z "$INPUT_FOLDER" || -z "$OUTPUT_FOLDER" ]]; then
  echo "Usage: $0 <INPUT_FOLDER> <OUTPUT_FOLDER> [NUM_DESIGNS]"
  exit 1
fi

# -------------------------
# Paths to slurm scripts
# -------------------------
BG_SLURM_SCRIPT="/n/home06/tbush/peptide_gen_pipeline/installation_scripts/bg_1st_run.slrm"

# -------------------------
# Output folders
# -------------------------
BG_OUTPUT_FOLDER="${OUTPUT_FOLDER}/bg"

mkdir -p "$BG_OUTPUT_FOLDER"

# -------------------------
# Inputs
# -------------------------
BG_INPUT_FILE="${INPUT_FOLDER}/design_config.yaml"

# -------------------------
# Launch BoltzGen
# -------------------------
echo "Launching BoltzGen..."
BG_JOBID=$(sbatch \
  --parsable \
  "$BG_SLURM_SCRIPT" \
  "$BG_INPUT_FILE" \
  "$BG_OUTPUT_FOLDER" \
  "$NUM_DESIGNS")

echo "BoltzGen JobID: $BG_JOBID"
