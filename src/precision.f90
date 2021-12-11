module mod_globals
use, intrinsic :: ISO_FORTRAN_ENV, only : REAL32, REAL64
implicit none
integer, parameter :: rk = REAL64  ! Replace with REAL32 to switch to the single precision
end module mod_globals

program precision
use mod_globals, only : rk  ! Single or double is controlled in mod_globals
implicit none
real(rk) :: x

x = 1.11111111111111
print *, x  ! -> 1.11111116409302  (Only single precision!)
x = 1.11111111111111_rk  ! Double precision
print *, x  ! -> 1.11111111111111
x = 1.11111111111111d0  ! Double precision
print *, x  ! -> 1.11111111111111
! Double precision can be read directly when rk=REAL64.
print *, 'Input 1.11111111111111'
read *, x
print *, 'x=', x  ! -> 1.111111111111111  (Double precision)
print *, 'Input 1.0e-2'
read *, x
print *, 'x=', x  ! ->  x=  1.000000000000000E-002  (Double precision)
print *, 'Input 1.0d-2'
read *, x
print *, 'x=', x  ! ->  x=  1.000000000000000E-002  (Double precision)

! rk cannot be used in input file
! print *, 'Input 1.11111111111111_rk'
! read *, x  ! Error: cannot read *_rk
! print *, 'x=', x

end program precision
