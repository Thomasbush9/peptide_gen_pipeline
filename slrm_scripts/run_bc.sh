#!/bin/bash
set -euo pipefail 
INPUT_FOLDER="${1:-}"
BC_SETTINGS_TARGET="${INPUT_FOLDER}/settings_target/target_settings.json"
BC_SETTINGS_FILTER="/n/home06/tbush/bindcraft/settings_filters/peptide_filters.json"
BC_SETTINGS_ADV="/n/home06/tbush/bindcraft/settings_advanced/peptide_3stage_multimer.json"
BC_DIR="/n/home06/tbush/bindcraft"
BC_SLURM_SCRIPT="${BC_DIR}/bindcraft.slurm"
echo "Launching BindCraft..."
cd "$BC_DIR"
BC_JOBID=$(sbatch --parsable "$BC_SLURM_SCRIPT" \
	  --settings "$BC_SETTINGS_TARGET" \
	    --filters "$BC_SETTINGS_FILTER" \
	      --advanced "$BC_SETTINGS_ADV")
echo "BindCraft JobID: $BC_JOBID"

echo "  BindCraft : $BC_JOBID"

