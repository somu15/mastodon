#!/bin/bash
#PBS -M Som.Dhulipala@inl.gov
#PBS -m abe
#PBS -N FSI_MSR
#PBS -P moose
#PBS -l select=1:ncpus=1:mpiprocs=12
#PBS -l walltime=150:00:00

JOB_NUM=${PBS_JOBID%%\.*}

cd $PBS_O_WORKDIR

\rm -f out
date > out
MV2_ENABLE_AFFINITY=0 mpiexec ~/projects/mastodon/mastodon-opt -i Real_Vessel_lv3.i >> out
date >> out
