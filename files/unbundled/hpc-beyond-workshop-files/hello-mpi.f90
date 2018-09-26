
      INCLUDE 'mpif.h'
      INTEGER error, rank

      CALL MPI_INIT(error)
      CALL MPI_COMM_RANK(MPI_COMM_WORLD, rank, error)
      PRINT *, "Hello world from ",rank
      CALL MPI_FINALIZE(error)

      STOP
      END


