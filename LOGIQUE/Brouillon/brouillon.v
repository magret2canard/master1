Definition rep2 (f : nat -> nat)(x:nat) := f (f x).

Definition add3 (x : nat) := x + 3.

Eval compute in rep2 add3 0.

Eval compute in (fun (x : nat) => x + 3) 1.


Check fun v : nat * nat => match v with (x, y) => x + y end.

Eval compute in (fun v : nat * nat => match v with (x, y) => x + y end) (3, 4).

Definition couple (v : nat * nat) := match v with (x, y) => x + y end.

Require Import Arith. 
Open Scope nat_scope.


Require Import ZArith. Open Scope Z_scope.Check (3, Z0, xH, xI, xO, Zpos (xO xH)).

Eval compute in iter 6 (Z*Z) 
     (fun p => let (x,r) := p in (x+1, (x+1)*r)) 
     (0, 1).

Locate "_ * _".

Require Import List.

Check 1::2::3::nil.

Eval compute in (1::2::3::nil) ++ (4::5::nil).

Eval compute in fold_right
                (fun x y => x + y) 
                0 
                (1::2::3::nil).


Eval compute in fold_left
                (fun x y => x + y) 
                (1::2::3::nil) 
                0.