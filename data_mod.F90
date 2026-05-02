module data_mod
   implicit none
   private

   integer, parameter, public :: r8 = selected_real_kind(12)

   type, public :: mytype
      real(r8), pointer :: data_p1(:)
      real(r8), pointer :: data_p2(:)
      real(r8), pointer, contiguous :: data_pc1(:)
      real(r8), pointer, contiguous :: data_pc2(:)
      real(r8), allocatable :: data_a1(:)
      real(r8), allocatable :: data_a2(:)
      real(r8) :: data_s1(300)
      real(r8) :: data_s2(300)
   end type

   type(mytype), public, target :: myinst

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
