#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=1
#SBATCH --mem=64GB
#SBATCH --partition=kempner_requeue
#SBATCH --account=kempner_bsabatini_lab
#try with bsabatini_lab
#SBATCH --time=03:00:00
# Use array-aware log names to avoid clobbering:
#SBATCH --output=/n/home06/tbush/job_logs/%x.%A_%a.out

set -euo pipefail
set -x

echo "Starting job on host: $(hostname)"
echo "SLURM job ID:        ${SLURM_JOB_ID:-unknown}"
echo "Array job ID:        ${SLURM_ARRAY_JOB_ID:-unknown}"
echo "Array task ID:       ${SLURM_ARRAY_TASK_ID:-unknown}"
echo "Nodes:               ${SLURM_JOB_NUM_NODES}"

if [[ $# -lt 3 ]]; then
  echo "Usage: $0 <design_spec> <outdir> <num_designs_per_job> <conda_environment>" >&2
  exit 1
fi

design_spec="$1"
outdir="$2"
num_designs="${3}"
conda_environment="${4}"
shift 4           # Remove parsed args
extra_args=("$@") # Store everything else

echo "Design spec: $design_spec"
echo "Output dir:  $outdir"
echo "Num designs: $num_designs"
echo "Conda environment: $conda_environment"
module load python/3.12.8-fasrc01 cudnn cuda
conda activate "$conda_environment"

which python
which boltzgen
nvidia-smi

job_outdir="${outdir}/task-${SLURM_ARRAY_JOB_ID}-${SLURM_ARRAY_TASK_ID}"
mkdir -p "${job_outdir}"

# Profile the whole boltzgen run (no cudaProfilerApi; NVTX ranges will appear in the report)
srun --ntasks=1 --gpus-per-task=1 \
  nsys profile \
  --gpu-metrics-devices=cuda-visible \
  --force-overwrite=true \
  --trace=cuda,cudnn,osrt,nvtx \
  --cudabacktrace=true \
  -x true \
  -o "${job_outdir}/report" \
  boltzgen run "$design_spec" \
  --output "${job_outdir}" \
  --num_designs "$num_designs" \
  "${extra_args[@]}"
