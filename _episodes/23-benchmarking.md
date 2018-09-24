---
title: "Benchmarking"
teaching: 25
exercises: 20
questions:
- "How do I benchmark programs?"
- "Can the compiler help optimize code for me?"
- "How do I find a good value for the number of processors I should use?"
objectives:
- "Be able to benchmark parallel programs"
keypoints:
- "Deciding how many processors to run on is an iterative task"
---

## Using the `time` command to benchmark code

We use the `time` command as an easy way to figure out how long our program ran. The `time` command 
can be used to time any command we can run at the shell, even trivial ones:

```
time echo "Howdy"
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

The `echo` command clearly isn't doing too much, so it takes very little time to run.
Lets compile a program that takes a non-trivial amount of time to execute.

```
mpif90 -o benchmark-demo-mpi benchmark-demo-mpi.f90 -O0
```
{: .bash}

The last part of the line is "minus oh zero" (a capital letter `O` followed by the number `0` after the minus sign). It tells the compiler that we want it to do very few optimizations while compiling our code.

For GNU compilers, this (`-O0`) is the default optimization level -- it generates slower code, but is quick to compile.
**TODO: figure out what this program actually does.**

For fun, lets compile it again, but now we will time the compilation:

```
time mpif90 -o benchmark-demo-mpi benchmark-demo-mpi.f90 -O0
```
{: .bash}

```

real    0m0.747s
user    0m0.266s
sys     0m0.167s

```
{: .output}

We can now time the execution of this program using a single processor:

```
time ./benchmark-demo-mpi
```
{: .bash}

```
  sum=   43788682263742496.     

real     0m8.943s
user     0m7.207s
sys      0m0.065s
```
{: .output}

Ideally, we would like to time our runs on a system with **no other users** on them -- otherwise the computational work done by others might influence the performance of your program as your program competes for resources with their programs. Timing on an isolated system also gives us a better chance that our timing is **reproducible**.

## Compiler optimizations

As mentioned previously, most compilers allow a choice for optimization level. We previously compiled with the flag `-O0` to produce the least optimized code.

There are higher optimization levels, namely `-O1`, `-O2`, and `-O3` (the highest). The more you allow the compiler to optimize your code, the longer it will take to compile, but the reward is usually a program that runs faster (sometimes significantly so).

Let's recompile our program with the highest optimization level:

```
time mpif90 -o benchmark-demo-mpi benchmark-demo-mpi.f90 -O3
```
{: .bash}
```

real    0m1.767s
user    0m0.233s
sys     0m0.116s

```
{: .output}

Now when you time your program again, you will likely see a drastic reduction in execution time:

```
time ./benchmark-demo-mpi
```
{: .bash}

```
  sum=   43788682263742496.     

real     0m1.519s
user     0m0.921s
sys      0m0.055s
```
{: .output}

Note: sometimes the compiler will take too many short cuts when optimizing code at high levels. It's always important to check that the answers from your program make sense!

## How many processors should I run my code on?

While we would like to speed up our program runs as much as we can, not all programs can make efficient
use of a large number of CPUs. At some point, the impact of the serial parts of your code, and the impacts
of interprocess communication will cause the efficiency of your program to decrease as you throw more
processors at a program. In some cases, adding additional processors for your program to use can actually
slow things down!

Worse though, the more processors you ask for, the less likely you will run soon in our cluster batch system.
The time you hope to save by using more processors may actually be replaced by time waiting for your job to run,
as other users might have more priority than you.

One final note: computational clusters are a shared resource, so each additional core you ask for is one
that blocks another user from running a job. If we know that asking for an additional core will only have a very
small effect on the total running time, let another user use that core instead. By only asking for what we
reasonably need, we can all have our jobs run sooner!

### Speedup and Parallel Efficiency

There are some metrics we can use to evaluate the performance of our parallel code:

"Speedup" is a measure of parallel efficiency.
**TODO: finish section**

Submit jobs

```
sbatch submit-benchmark-job.sh
```
{: .bash}

**TODO: flesh this out**

[JS for plotting Timing, Speedup, and Efficiency](https://jsfiddle.net/cwant/rf48toug/){:target="_blank"}

**TODO**: get users to discuss among themselves where the sweet spot is
Do you only care about walltime, or do you also care about efficiency? The answer to these will infllsdjfkewrlfjwe
Add comment about many serial runs possibly being good for a parameter sweep situation

**TODO**: This job might have problems because it runs pretty quick anyways, so the overhead of setting up the parallelism might outweight the advantage from parallelism

