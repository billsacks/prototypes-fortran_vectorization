module data_mod
   implicit none
   private

   type, public :: mytype
      real, pointer :: data_p1(:)
      real, pointer :: data_p2(:)
      real, pointer, contiguous :: data_pc1(:)
      real, pointer, contiguous :: data_pc2(:)
      real, allocatable :: data_a1(:)
      real, allocatable :: data_a2(:)
      real :: data_s1(300)
      real :: data_s2(300)
   end type

   type(mytype), public :: myinst

   public :: init

contains

   subroutine init()
      allocate(myinst%data_p1(300))
      allocate(myinst%data_p2(300))
      allocate(myinst%data_pc1(300))
      allocate(myinst%data_pc2(300))
      allocate(myinst%data_a1(300))
      allocate(myinst%data_a2(300))
   end subroutine init

end module data_mod
