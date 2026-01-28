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
BC_SLURM_SCRIPT="/n/home06/tbush/bindcraft/bindcraft.slurm"

# -------------------------
# Output folders
# -------------------------
BG_OUTPUT_FOLDER="${OUTPUT_FOLDER}/bg"
BC_OUTPUT_FOLDER="${OUTPUT_FOLDER}/bc"

mkdir -p "$BG_OUTPUT_FOLDER" "$BC_OUTPUT_FOLDER"

# -------------------------
# Inputs
# -------------------------
BG_INPUT_FILE="${INPUT_FOLDER}/design_config.yaml"
#TODO: add a script to automatically fill both settings
BC_SETTINGS_TARGET="${INPUT_FOLDER}/settings_target/target_settings.json"
BC_SETTINGS_FILTER="${INPUT_FOLDER}/settings_filters/filter_settings.json"
BC_SETTINGS_ADV="${INPUT_FOLDER}/settings_adv/adv_settings.json"

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

# -------------------------
# Launch BindCraft
# -------------------------
echo "Launching BindCraft..."

BC_JOBID=$(sbatch \
  --parsable \
  "$BC_SLURM_SCRIPT" \
  --settings "$BC_SETTINGS_TARGET" 
  # --filters "$BC_SETTINGS_FILTER" \
  # --advanced "$BC_SETTINGS_ADV")
  #
echo "BindCraft JobID: $BC_JOBID"
echo "Submitted jobs:"
echo "  BoltzGen : $BG_JOBID"
echo "  BindCraft : $BC_JOBID"
