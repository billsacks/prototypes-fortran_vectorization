module doit_mod
   use data_mod, only : r8, mytype
   implicit none
   private

   public :: doit
   public :: doit_with_args
contains

   subroutine doit(local_inst)
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
   end subroutine doit

   subroutine doit_with_args(data1, data2)
      real(r8), intent(out), contiguous :: data1(:)
      real(r8), intent(in), contiguous :: data2(:)

      integer :: n

      do n = 1, 300
         data1(n) = data2(n) * data2(n) + data2(n)
      end do

   end subroutine doit_with_args

end module doit_mod
