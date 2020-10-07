program main
  !$ use omp_lib
  implicit none
  integer :: i, j, k
  integer :: t1, t2, CountPerSec, CountMax
  integer, parameter :: N = 512
  real(4), dimension(1:N,1:N) :: a, b, c
  character(32) :: OutputFile

  ! Define the components of matrices
  call set_matrix(a,b)

  ! Calculation of matrix product.
    call system_clock(t1,CountPerSec,CountMax)
  call matrix_product(a,b,c)
    call system_clock(t2)
    write (*,*) "Calculation time: ", real(t2-t1)/real(CountPerSec), "[s]"

  ! Output the result.
  OutputFile = 'result.dat'
  call print_matrix(c,OutputFile)


  contains

    subroutine matrix_product(a,b,c)
      implicit none
      real(4), intent(in), dimension(1:N,1:N) :: a, b
      real(4), intent(out), dimension(1:N,1:N) :: c

      !$omp parallel do private(k)
      do i = 1, N
        do j = 1, N
          c(i,j) = 0.0
          do k = 1, N
            c(i,j) = c(i,j) + a(i,k)*b(k,j)
          end do
        end do
      end do
      !$omp end parallel do

    end subroutine matrix_product

    subroutine set_matrix(a,b)
      implicit none
      real(8) :: rnd1, rnd2
      real(4), intent(inout), dimension(1:N,1:N) :: a, b

      do i = 1, N
        do j = 1, N
          call random_number(rnd1)
          call random_number(rnd2)
          a(i,j) = rnd1
          b(i,j) = rnd2
          !if ( i == j ) then
          !  a(i,j) = i
          !  b(i,j) = 2.0
          !else
          !  a(i,j) = 0.0
          !  b(i,j) = 0.0
          !end if
        end do
      end do

    end subroutine set_matrix

    subroutine print_matrix(a, OutputFile)
      implicit none
      real(4), intent(in), dimension(1:N,1:N) :: a
      character(32), intent(in) :: OutputFile
      character(32) :: ii, jj

      open (32, file=OutputFile, status='replace')
      do i = 1, N
        write (ii,*) i
        do j = 1, N
          write (jj,*) j
          write (32,*) "(", trim(adjustl(ii)), ",", trim(adjustl(jj)), ")=", a(i,j) 
        end do
      end do
      close (32)

    end subroutine print_matrix

    !subroutine hello_world
    !  do j = 1, 100
    !    open (11,file='buffe',status='replace')
    !    do i = 1, 10000
    !      write (11,*) "Hello, world."
    !    end do
    !    close (11)
    !  end do
    !end subroutine hello_world


end program main
