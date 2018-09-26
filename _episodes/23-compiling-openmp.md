---
title: "Compiling OpenMP code on a cluster"
teaching: 15
exercises: 5
questions:
- "How do I compile and run OpenMP programs?"
objectives:
- "Be able to compile an OpenMP program"
keypoints:
- "`gcc` with the `-fopenmp` flag compiles OpenMP code written in C"
- "`gfortran` with the `-fopenmp` flag compiles OpenMP code written in Fortran"
- "The program generated is run as usual, but the number of processors is controlled with the `OMP_NUM_THREADS` environment variable"
---

From Wikipedia:

> OpenMP (Open Multi-Processing) is an application programming interface (API) that supports multi-platform shared memory multiprocessing programming in C, C++, and Fortran, ... . It consists of a set of compiler directives, library routines, and environment variables that influence run-time behavior.

OpenMP programs are typically compiled with a standard compiler (e.g. `gcc` or `gfortran`), with an option applied to modify the compiler's behaviour to understand OpenMP directives.

## Compiling an OpenMP C program

There is an OpenMP program written in C in the workshop files. In this version of
the program, each separate parallel process says 'Hello world', and reports it's
thread number (a thread is a "light-weight" process, and it's number is like the **rank** of an MPI process).

We compile the program with good 'ol  `gcc`:

```
gcc -o hello-omp -fopenmp hello-omp.c
```
{: .bash}

Notice the `-fopenmp` flag -- this tells the compiler we are compiling an
OpenMP program.

## Running an OpenMP program

We run the compiled program, using the environment variable 'OMP_NUM_THREADS` to control the number of threads:
```
OMP_NUM_THREADS=4 ./hello-omp 
```
{: .bash}
```
Hello World from thread = 0
Number of threads = 4
Hello World from thread = 2
Hello World from thread = 1
Hello World from thread = 3
```
{: .output}

The thread numbers are reported in a somewhat random order, much like the
MPI program's ranks were reported.

## Compiling and running an OpenMP FORTRAN program

In the workshop files, there is a 'hello world' OpenMP program written in Fortran.
We compile it with `gfortran`, and again supply the `-fopenmp` flag:

```
gfortran -o hello-omp-fortran -fopenmp hello-omp.f90
```
{: .bash}

It is run in the exact same way that we ran the C program:

```
OMP_NUM_THREADS=4 ./hello-omp-fortran
```
{: .bash}
```
 Hello World from thread =            3
 Hello World from thread =            0
 Number of threads =            4
 Hello World from thread =            1
 Hello World from thread =            2
```
{: .output}

> ## Exercise: Submitting our program to the scheduler
>
> Write a slurm submission script that runs our OpenMP program using
> **2 threads**.
> Submit your script to slurm and checkout the job output.
{: .challenge}
