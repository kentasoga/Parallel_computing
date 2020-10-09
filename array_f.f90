program main
  implicit none
  integer, parameter :: N = 4096
  integer :: i, j, t1, t2, CountPerSec, CountMax
  integer, dimension(1:N,1:N) :: a, b

  a = 1
  b = 0

  call system_clock(t1,CountPerSec,CountMax)
  do i = 1, N
    do j = 1, N
      b(i,j) = a(i,j)
    end do
  end do
  call system_clock(t2)
  write (*,*) "t1=", real(t2-t1)/real(CountPerSec), "[s]"

  call system_clock(t1,CountPerSec,CountMax)
  do i = 1, N
    do j = 1, N
      b(j,i) = a(j,i)
    end do
  end do
  call system_clock(t2)
  write (*,*) "t2=", real(t2-t1)/real(CountPerSec), "[s]"

end program main
