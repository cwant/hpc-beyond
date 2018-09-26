#include <stdio.h>
#include <mpi.h> 

int main (int argc, char *argv[]) {

  int rank,len;
  char name[255];

  MPI_Init(&argc, &argv);                 /* Initialize MPI       */
  MPI_Comm_rank(MPI_COMM_WORLD, &rank); /* Get my rank          */
  MPI_Get_processor_name(name,&len);
  printf("Hello world from %d %s\n", rank,name);

  MPI_Finalize();                         /* Terminate MPI        */

}
