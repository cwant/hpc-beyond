  parameter (nmax=10000000)
  
      include 'mpif.h'
      real x(nmax),y(nmax)
      real*8 sum
      common /arry/x,y
      integer npart, nrest
      integer error, rank, size, status(mpi_status_size)

      call mpi_init(error)
      call mpi_comm_rank(mpi_comm_world, rank, error)
      call mpi_comm_size(mpi_comm_world, size, error)

      npart = nmax/size
      nrest = nmax - npart*size
      if(nrest .ne. 0)then
        write(*,*)' size =',size,' should be a factor of nmax =',nmax
        stop
      endif

      if(rank .eq. 0)then
      do 100 i=1, nmax
        x(i) = i
  100 continue
        if(size .gt. 1)then
        do 200 iproc = 1, size-1
          index = iproc*npart+1
          call mpi_send(x(index),npart,mpi_real,iproc,1,mpi_comm_world,error)
  200   continue
        endif
        do 210 i = 1, npart
              y(i)=0
          do j = 1, 8
              y(i) = y(i)+(x(i)**2.3/x(i))
          enddo
  210   continue
        if(size .gt. 1)then
        do 215 iproc = 1, size-1
          index = iproc*npart+1
          call mpi_recv(y(index),npart,mpi_real,iproc,2,mpi_comm_world,status,error)
  215   continue
        endif
        sum = 0
        do 300 i=1,nmax
          sum = sum + y(i)
  300   continue
        write(*,*)' sum=',sum
      else
        call mpi_recv(x,npart,mpi_real,0,1,mpi_comm_world,status,error)
        do 220 i=1,npart
              y(i)=0
          do j = 1, 8
              y(i) = y(i)+(x(i)**2.3/x(i))
          enddo
  220   continue
        call mpi_send(y,npart,mpi_real,0,2,mpi_comm_world,error)
      endif
      
      call mpi_finalize(error)

      stop
      end
