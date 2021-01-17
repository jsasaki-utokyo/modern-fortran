! Sourced allocation in Object-oriented programming (Metcalf et al., 2018) 15.4.4 (p.298-)
! allocate (a, source=b) は配列bのindexの下限，上限が配列aに引き継がれる
module mod_source_allocation
    implicit none
    type :: t
        integer :: x
        real :: y
    end type t

contains

    subroutine s_set(b)
        ! Set lower and upper bounds
        ! 次行はtype(t)でもよいが，tを拡張した型に対応できるclass(t)が汎用的
        class(t), intent(in) :: b(:)                                 ! 形状引継ぎ仮配列 assumed-shape array
        ! 割付仮配列も可能
        !   割付仮配列とする場合の要件：実引数も割付配列，実引数と仮引数は同一type，引用仕様明示
        !   同一typeの条件より，仮引数をclassにするとエラーとなる
        !   type(t), intent(in), allocatable  :: b(:)                   ! 割付仮配列  
        !!! class(t), intent(in), allocatable  :: b(:)                ! Error
        class(t), allocatable :: a(:)
        allocate (a(lbound(b,1):ubound(b,1)), source=b)  ! 配列indexの下限と上限を指定
        print *, 's_set a=', a(:)%x, a(:)%y
    end subroutine s_set

    subroutine s(b)
        class(t) :: b(:)
        class(t), allocatable :: a(:)
        allocate (a, source=b)                           ! 配列indexの下限と上限を指定しない
        print *, 's a=', a(:)%x, a(:)%y
    end subroutine s

end module mod_source_allocation

program source_allocation
    use mod_source_allocation
    implicit none

    type(t), allocatable :: b(:)
    allocate(t :: b(0:1))                                ! 配列indexの下限0，上限1と指定
    b(0) = t(1, 1.0)
    b(1) = t(2, 2.0)
    print *, 'b=', b%x, b%y
    ! 配列bのindexの下限，上限を組込関数lbount()，ubound()から取得
    call s_set(b)
    ! 配列indexの下限・上限は実引数から取得
    call s(b)

end program source_allocation
