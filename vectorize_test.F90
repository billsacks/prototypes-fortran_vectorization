program driver
   use data_mod, only : myinst, init
   use doit_mod, only : doit

   implicit none
   integer :: c

   call init()

   ! Pointer
   do c = 1, 300
      myinst%data_p1(c) = myinst%data_p2(c) * myinst%data_p2(c) + myinst%data_p2(c)
   end do
   print *, myinst%data_p1(300)

   ! Pointer, contiguous
   do c = 1, 300
      myinst%data_pc1(c) = myinst%data_pc2(c) * myinst%data_pc2(c) + myinst%data_pc2(c)
   end do
   print *, myinst%data_pc1(300)

   ! Allocatable
   do c = 1, 300
      myinst%data_a1(c) = myinst%data_a2(c) * myinst%data_a2(c) + myinst%data_a2(c)
   end do
   print *, myinst%data_a1(300)

   ! Static
   do c = 1, 300
      myinst%data_s1(c) = myinst%data_s2(c) * myinst%data_s2(c) + myinst%data_s2(c)
   end do
   print *, myinst%data_s1(300)

   ! Pointer, associated
   associate(data_p1 => myinst%data_p1, data_p2 => myinst%data_p2)
   do c = 1, 300
      data_p1(c) = data_p2(c) * data_p2(c) + data_p2(c)
   end do
   print *, data_p1(300)
   end associate

   ! Pointer, contiguous, associated
   associate(data_pc1 => myinst%data_pc1, data_pc2 => myinst%data_pc2)
   do c = 1, 300
      data_pc1(c) = data_pc2(c) * data_pc2(c) + data_pc2(c)
   end do
   print *, data_pc1(300)
   end associate

   ! Allocatable, associated
   associate(data_a1 => myinst%data_a1, data_a2 => myinst%data_a2)
   do c = 1, 300
      data_a1(c) = data_a2(c) * data_a2(c) + data_a2(c)
   end do
   print *, data_a1(300)
   end associate

   ! Static, associated
   associate(data_s1 => myinst%data_s1, data_s2 => myinst%data_s2)
   do c = 1, 300
      data_s1(c) = data_s2(c) * data_s2(c) + data_s2(c)
   end do
   print *, data_s1(300)
   end associate

   call doit(myinst)

end program
