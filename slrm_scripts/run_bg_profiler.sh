#!/bin/bash
set -e
set -x

DESIGN_SPEC=/n/home06/tbush/peptide_gen_pipeline/configs/design_config.yaml
MERGED_OUT=/n/home06/tbush/outputs
NUM_TASKS=1
NUM_DESIGNS_PER_TASK=50
CONDA_ENVIRONMENT=/n/home06/tbush/envs/bg
CACHE_DIR="/n/holylabs/bsabatini_lab/Lab/Boltz-project/cache_models/bg/"
ACCOUNT=kempner_bsabatini_lab
TIME=03:00:00

OUT="${MERGED_OUT}/task-outputs"
LOGS="${MERGED_OUT}/task-logs"

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 {submit|process}"
  exit 1
fi

MODE="$1"

if [[ "$MODE" == "submit" ]]; then

  mkdir -p "$OUT"
  mkdir -p "$LOGS"

  sbatch -A "$ACCOUNT" -t "$TIME" --export=ALL --array=1-$NUM_TASKS -o $LOGS/stdout.%A-%a.log -e $LOGS/stderr.%A-%a.log run_bg_profiler.slurm \
    "$DESIGN_SPEC" "$OUT" "$NUM_DESIGNS_PER_TASK" "$CONDA_ENVIRONMENT" --protocol protein-anything --cache "$CACHE_DIR"
  squeue --me

elif [[ "$MODE" == "process" ]]; then

  sbatch -A "$ACCOUNT" -t 04:00:00 --export=ALL merge_bg.slrm \
    "$DESIGN_SPEC" "$OUT" "$MERGED_OUT" "$CONDA_ENVIRONMENT"

else
  echo "Usage: $0 {submit|process}"
  exit 1
f
