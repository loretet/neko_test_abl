! Linnea Huusko 27/2-2025
module user
  use neko
  implicit none

  real(kind=rp) :: ugeo

contains

  ! Register user defined functions (see user_intf.f90)
  subroutine user_setup(u)
    type(user_t), intent(inout) :: u

    ugeo = 10

    u%fluid_user_ic => user_ic
    u%scalar_user_ic => scalar_ic
  end subroutine user_setup

  ! User defined initial condition
  subroutine user_ic(u, v, w, p, params)
    type(field_t), intent(inout) :: u
    type(field_t), intent(inout) :: v
    type(field_t), intent(inout) :: w
    type(field_t), intent(inout) :: p
    type(json_file), intent(inout) :: params
    integer :: i
    real(kind=rp) :: x, y, z
    real(kind=rp) :: eps, kx, ky, lx, ly, alpha, beta, gamma, delta, PI

    PI = (4.*atan(1.))

    kx  = 5
    ky  = 7
    lx  = 40
    ly  = 40
    eps = 0.4


    alpha = kx * PI / 1500
    beta  = ky * PI / 1500
    gamma = lx * PI / 1500
    delta = ly * PI / 1500

    do i = 1, u%dof%size()
      u%x(i,1,1,1) = ugeo
      v%x(i,1,1,1) = 0
      w%x(i,1,1,1) = 0
      x = u%dof%x(i,1,1,1)
      y = u%dof%y(i,1,1,1)
      z = u%dof%z(i,1,1,1)
      if (z .le. 50) then ! Small perturbation to help get turbulence started
        u%x(i,1,1,1) = u%x(i,1,1,1) + eps*(sin(alpha*x)*sin(beta*y)) &
                    + eps*(sin(gamma*x)*sin(delta*y))
        v%x(i,1,1,1) = w%x(i,1,1,1) + eps*(sin(alpha*x)*sin(beta*y)) &
        + eps*(sin(gamma*x)*sin(delta*y))
        w%x(i,1,1,1) = v%x(i,1,1,1) - eps*(alpha * cos(alpha*x)*sin(beta*y)) &
        - eps*(gamma * cos(gamma*x)*sin(delta*y))
      endif
   end do
  end subroutine user_ic

  subroutine scalar_ic(s, params)
    type(field_t), intent(inout) :: s
    type(json_file), intent(inout) :: params
    real(kind=rp) :: z

    integer :: i

    do i = 1, s%dof%size()
      z = s%dof%z(i,1,1,1)
      if (z.le.500) then
        s%x(i,1,1,1) = 300
      elseif (z.le.550) then
        s%x(i,1,1,1) = 300 + (z - 500)*0.08
      else
        s%x(i,1,1,1) = 303.96 + (z - 550)*0.003
      endif
   end do

  end subroutine scalar_ic

end module user
