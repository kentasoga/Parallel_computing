program main
  implicit none
  include 'mpif.h'
  integer, parameter :: N = 100
  integer :: i_start, i_end, i, j, k, nprocs, myrank, ierr, dN
  integer :: sum0, sum1

  call MPI_INIT(IERR)
  call MPI_COMM_SIZE(MPI_COMM_WORLD,nprocs,ierr)
  call MPI_COMM_RANK(MPI_COMM_WORLD,myrank,ierr)

  !dN = N / nprocs
  !i_start = 1 + myrank*dN
  !i_end = i_start + dN - 1

  if(mod(N,nprocs).eq.0) then
     dN = N/nprocs
     i_start = dN*myrank + 1
     i_end = i_start + dN - 1
  else
     if(myrank.le.mod(N,nprocs)-1)then
        dN = (N - mod(N,nprocs))/(nprocs)+1
        i_start = dN*myrank + 1
        i_end = i_start + dN - 1
     else
        dN = (N - mod(N,nprocs))/(nprocs)
        i_start = (dN+1)*mod(N,nprocs) &
               + dN*(myrank - mod(N,nprocs)) + 1
        i_end = i_start + dN - 1
     end if
  end if
  !write (*,*) "myrank:", myrank, "i_start:", i_start, "i_end:",i_end

  sum0 = 0
  do i = i_start, i_end
    sum0 = sum0 + i
  end do

  call MPI_ALLREDUCE(sum0,sum1,1,MPI_INTEGER,MPI_SUM,MPI_COMM_WORLD,IERR)
  if ( myrank == 0 ) write (*,*) "sum = ", sum1

  call MPI_FINALIZE(ierr)

end program main
