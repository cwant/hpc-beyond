---
title: "Compiling MPI code on a cluster"
teaching: 15
exercises: 5
questions:
- "How do I compile C and FORTRAN programs?"
- "What compilers can I use?"
objectives:
- "Be able to compile a basic C or FORTRAN program"
keypoints:
- "Compilers turn instuctions in programming languages to machine code that the computer can execute"
---

## Why Use A Compiled Language?

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
