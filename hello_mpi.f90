program main
  include 'mpif.h'
  integer :: ierr

  call MPI_INIT(IERR)
  write (*,*) "Hello, world."
  call MPI_FINALIZE(ierr)

end program main
