#!/bin/bash 
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=00:05:00

{ time mpiexec -n 1 ./benchmark-demo-mpi ; } 2>out.time
{ time mpiexec -n 2 ./benchmark-demo-mpi ; } 2>>out.time
{ time mpiexec -n 4 ./benchmark-demo-mpi ; } 2>>out.time

# Uncomment the following lines for larger clusters
# (and adjust --ntasks-per-node above)

# { time mpiexec -n 8 ./benchmark-demo-mpi ; } 2>>out.time
# { time mpiexec -n 16 ./benchmark-demo-mpi ; } 2>>out.time
