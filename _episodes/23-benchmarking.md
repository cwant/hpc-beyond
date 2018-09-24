---
title: "Benchmarking"
teaching: 15
exercises: 5
questions:
- "How do I benchmark programs?"
- "How do I found a good value for the number of processors I should use?"
objectives:
- "Be able to benchmark parallel programs"
keypoints:
- "Deciding how many processors to run on is an iterative task"
---

## How many processors should I run my code on?

While we would like to speed up our program runs as much as we can, not all programs can make efficiently
use of a large number of CPUs. At some point, the impact of the serial parts of your code, and the impacts
of interprocess communication will cause the efficiency of your program to decrease as you throw more
processors at a program. In some cases, adding additional processors for your program to use can actually
slow things down!

Worse though, the more processors you ask for, the less likely you will run soon in our cluster batch system.
The time you hope to save by using more processors may actually be replaced by time waiting for your job to run,
as other users might have more priority than you.

One final note: since the Compute Canada clusters are a shared resource, so each additional core you ask for is one
that blocks another user from running a job. If we know that asking for an additional core will only have a very
small effect on the total running time, let another user use that core instead. By only asking for what we
reasonbly need, we can all have our jobs run sooner!

## Using the `time` command

We use the `time` command as an easy way to figure out how long our program ran. The `time` command 
can be used to time any command we can run at the shell, even trivial ones:

```
time echo "Howdy:
```
{: .bash}

```
Howdy

real    0m0.000s
user    0m0.000s
sys     0m0.000s
```
{: .output}

The measurement we are interested is **walltime** -- it shows up on the row that starts with `real`. This is the actual time the code was running, from start to finish. (The word **walltime** can be interpretted as "the time we observe looking at the time on the wall". As computational researchers who want results as fast as possible, this is the measurement type that is most important to us.

The other two rows in the output are `user` and `system` measurements of CPU time. They report how much CPU time the code used (`user`), and how much time the operating system kernel spend servicing the program (`system`). They are more difficult to interpret, and we won't discuss them today.

Lets compile a program that takes a non-trivial amount of time to execute.

```
mpif90 -o benchmark-demo-mpi benchmark-demo-mpi.f90 -O0
```
{: .bash}

For fun, lets compile it again, but now we will time the compilation:

```
time mpif90 -o benchmark-demo-mpi benchmark-demo-mpi.f90 -O0
```
{: .bash}



The `echo` command clearly isn't doing too much, so it takes very little ri
Ideally, we would like to time our runs on a system with **no other users** on them -- otherwise the work done by others might influence the performance of your program. This also ensures that our timing is **reproducible**.


**TODO**: Clean this up

```
mpif90 -o benchmark-demo-mpi benchmark-demo-mpi.f90 -O0
```
{: .bash}

The last part of the line is "minus oh zero" (a capital letter `O` followed by the number `0` after the minus sign). It tells the compiler that we want it to do very few optimizations while compiling our code.

Submit jobs

```
sbatch submit-benchmark-job.sh
```
{: .bash}


## **TODO**: Everything

## Setting up the environment to compile programs

The Intel compiler is licensed on all of the Compute Canada clusters, and
it is the preferred compiler to use. This is because Intel designed the
CPU chips in our cluster, so their compilers will create better
optimized code to run on these chips.

We do not have a license for the Intel
Compiler on our training cluster, so we need to use the free compiler `gcc`.
In order to use the compiler, we need to load into our work environment:

```
module load gcc
```
{: .bash}

## Compiling our first C program

Now that we have a compiler loaded, lets compile a simple C program

```
gcc -o hello hello.c
```
{: .bash}

(TODO: icc)

## Running our compiled C program

We can run the program with:

```
./hello
```
{: .bash}

Notice that we didn't just type `hello` to run our new program. Here that the dot (`.`) at the beginning of the command refers to the current directory we are in, and tells our shell where to find the `hello` program. If we did not do this, the shell may not be able to find our program, or it could even find a different hello program and run that instead. For example, in the standard path `/usr/bin`, if there is a command called `hello`.


```
gfortran -o hello_fortran hello.f90
```
{: .bash}

Run the compiled fortran program with:
```
./hello_fortran
```
{: .bash}

Note: the `-o` flag tells the compiler where to output the compiled machine code. If you exclude the `-o` flag, the machine code will be writen to a file called `a.out`. This compiled program can be run with:

```
./a.out
```
{: .bash}

> ## Find out which modules are on your system
>
> **TODO: Fill this in and move it to the right spot**
{: .challenge}
