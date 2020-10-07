program main
  !$ use omp_lib
  implicit none
  integer :: i, sum

  sum = 0
  !$omp parallel
  !$omp do private(i)
  do i = 1, 10
    sum = sum + i
    write (*,*) "i=",i, "my thread num=", omp_get_thread_num()
  end do
  !$omp enddo
  !$omp end parallel
  write (*,*) "sum=", sum

end program main

