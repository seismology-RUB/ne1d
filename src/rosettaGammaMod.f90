!-----------------------------------------------------------------------
!   Copyright 2014-2020 Thomas Möller (Ruhr-Universität Bochum, GER)
!   Copyright 2014-2020 Marc S. Boxberg (RWTH Aachen University, GER)
!
!   This file is part of NEXD 1D.
!
!   This program is free software: you can redistribute it and/or modify
!   it under the terms of the GNU General Public License as published by
!   the Free Software Foundation, either version 3 of the License, or
!   (at your option) any later version.
!
!   This program is distributed in the hope that it will be useful, but
!   WITHOUT ANY WARRANTY; without even the implied warranty of
!   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
!   GNU General Public License for more details.
!
!   You should have received a copy of the GNU General Public License
!   along with NEXD 1D. If not, see <http://www.gnu.org/licenses/>.
!---------------------------------
module rosettaGammaMod
    ! Temporary use this gamma implementation, because our ifort has no gamma.
    ! Source: http://rosettacode.org/wiki/Gamma_function#Fortran

    use constantsMod

    contains

    recursive function lacz_gamma(a) result(g)
        real(kind=custom_real), intent(in) :: a
        real(kind=custom_real) :: g

        !real(kind=custom_real), parameter :: pi = 3.14159265358979324
        integer, parameter :: cg = 7

        ! these precomputed values are taken by the sample code in Wikipedia,
        ! and the sample itself takes them from the GNU Scientific Library
        real(kind=custom_real), dimension(0:8), parameter :: p = &
            (/ 0.99999999999980993, 676.5203681218851, -1259.1392167224028, &
            771.32342877765313, -176.61502916214059, 12.507343278686905, &
            -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7 /)

        real(kind=custom_real) :: t, w, x
        integer :: i

        x = a

        if ( x < 0.5 ) then
            g = pi / ( sin(pi*x) * lacz_gamma(1.0-x) )
        else
            x = x - 1.0
            t = p(0)
            do i=1, cg+1
                t = t + p(i)/(x+real(i))
            end do
            w = x + real(cg) + 0.5
            g = sqrt(2.0*pi) * w**(x+0.5) * exp(-w) * t
        end if
    end function lacz_gamma
end module rosettaGammaMod
