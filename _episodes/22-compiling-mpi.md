---
title: "Compiling MPI code on a cluster"
teaching: 15
exercises: 10
questions:
- "How do I compile and run MPI programs?"
objectives:
- "Be able to compile and run an MPI program"
keypoints:
- "mpicc compiles MPI code written in C"
- "mpif90 compiles MPI code written in Fortran (90)"
- "mpirun is used to run MPI programs, specifying the number of processors with the -np flag"
- "The rank of an MPI process does not determine which process starts or finishes first"
---

From Wikipedia:

> Message Passing Interface (MPI) is a standardized and portable message-passing standard designed by a group of researchers from academia and industry to function on a wide variety of parallel computing architectures. The standard defines the syntax and semantics of a core of library routines useful to a wide range of users writing portable message-passing programs in C, C++, and Fortran.

The primary feature of programs using an MPI library is that the program spawns multiple processes, and each process use a different private address spaces. The processes pass messages between each other to share data and to orchestrate the work.

MPI programs are typically compiled with a wrapper that helps handle the specifics of accessing a particular MPI library (e.g., mpicc, mpif90).

## Compiling an MPI C program

There is an MPI program written in C in the workshop files. In this version of
the program, each separate parallel process says 'Hello world', and reports it's
rank. The **rank** of an MPI process is a number between one and the number of
processors you are running on that serves as an ID number for the process. 

We compile the program with the `mpicc` program:

```
mpicc -o hello-mpi hello-mpi.c
```
{: .bash}

## Running an MPI program

We use the `mpirun` program to run the compiled MPI program:
```
mpirun -np 4 hello-mpi
```
{: .bash}
```
Hello world from 2 training01.training.uofa.c3.ca
Hello world from 3 training01.training.uofa.c3.ca
Hello world from 0 training01.training.uofa.c3.ca
Hello world from 1 training01.training.uofa.c3.ca
```
{: .output}

The flag `-np` specifies how many processors we want to run on (in this case 4).
Look at the output and notice that the rank reported by each process is not
in numerical order -- the ranks are reported in the order that the print commands
are executed for the processes.

## Compiling and running an MPI FORTRAN program

In the workshop files, there is a 'hello world' MPI program written in FORTRAN.
We compile it with:

```
mpif90 -o hello-mpi-fortran hello-mpi.f90
```
{: .bash}

It is run in the exact same way that we ran the C program:

```
mpirun -np 4 hello-mpi-fortran
```
{: .bash}
```
 Hello world from            0
 Hello world from            1
 Hello world from            3
 Hello world from            2
```
{: .output}

> ## Submitting our program to the scheduler
>
> Let's create a slurm submission script called `submit-hello-mpi-job.sh`.
> Open an editor (e.g. Nano) and type (or copy/paste) the following contents:
>
> ~~~
> #!/bin/bash 
> #SBATCH --nodes=1
> #SBATCH --ntasks-per-node=4
> #SBATCH --time=00:05:00
>
> mpirun -np 4 hello-mpi
> ~~~
> {: .bash}
>
> Notice that the number of processors we are requesting matches the number of
> processors we are telling MPI to run with
>
> We can now submit the job using the `sbatch` command:
> ```
> sbatch submit-hello-mpi-job.sh
> ```
> {: .bash}
> As with previous examples, note the job id and check your job in the queue.
> Take a look at the output file when the job completes
{: .challenge}
