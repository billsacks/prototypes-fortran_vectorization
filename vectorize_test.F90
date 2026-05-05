program driver
   use data_mod, only : myinst, init
   use doit_mod, only : doit, doit_with_args

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

   call doit_local(myinst)
   call doit(myinst)
   call doit_with_args(myinst%data_a1, myinst%data_a2)
contains

   subroutine doit_local(local_inst)
      use data_mod, only : mytype
      type(mytype), intent(inout) :: local_inst
      integer :: n

      ! Pointer
      do n = 1, 300
         local_inst%data_p1(n) = local_inst%data_p2(n) * local_inst%data_p2(n) + local_inst%data_p2(n)
      end do
      print *, local_inst%data_p1(300)

      ! Pointer, contiguous
      do n = 1, 300
         local_inst%data_pc1(n) = local_inst%data_pc2(n) * local_inst%data_pc2(n) + local_inst%data_pc2(n)
      end do
      print *, local_inst%data_pc1(300)

      ! Allocatable
      do n = 1, 300
         local_inst%data_a1(n) = local_inst%data_a2(n) * local_inst%data_a2(n) + local_inst%data_a2(n)
      end do
      print *, local_inst%data_a1(300)

      ! Static
      do n = 1, 300
         local_inst%data_s1(n) = local_inst%data_s2(n) * local_inst%data_s2(n) + local_inst%data_s2(n)
      end do
      print *, local_inst%data_s1(300)

      ! Pointer, associated
      associate(data_p1 => local_inst%data_p1, data_p2 => local_inst%data_p2)
      do n = 1, 300
         data_p1(n) = data_p2(n) * data_p2(n) + data_p2(n)
      end do
      print *, data_p1(300)
      end associate

      ! Pointer, contiguous, associated
      associate(data_pc1 => local_inst%data_pc1, data_pc2 => local_inst%data_pc2)
      do n = 1, 300
         data_pc1(n) = data_pc2(n) * data_pc2(n) + data_pc2(n)
      end do
      print *, data_pc1(300)
      end associate

      ! Allocatable, associated
      associate(data_a1 => local_inst%data_a1, data_a2 => local_inst%data_a2)
      do n = 1, 300
         data_a1(n) = data_a2(n) * data_a2(n) + data_a2(n)
      end do
      print *, data_a1(300)
      end associate

      ! Static, associated
      associate(data_s1 => local_inst%data_s1, data_s2 => local_inst%data_s2)
      do n = 1, 300
         data_s1(n) = data_s2(n) * data_s2(n) + data_s2(n)
      end do
      print *, data_s1(300)
      end associate
   end subroutine doit_local

end program
