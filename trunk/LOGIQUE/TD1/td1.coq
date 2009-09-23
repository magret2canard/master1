Definition three := 3.
Check three.
Eval compute in three.
Check 2 + 3.
Check 5 + 3.
Definition add3 (x : nat) := x + 3.

Definition somme_carre(a b : nat) := a*a + b*b.
Check somme_carre 4 5.
Eval compute in somme_carre 4 5.

Require Import Arith.
Open Scope nat_scope.
Fixpoint somme_carre_n (x : nat) := match x with 0 => 0 | S p => x * x + somme_carre_n p end.
Eval compute in somme_carre_n 5.

Require Import List.
Fixpoint list_n (n : nat) := match n with 0 => nil | S p => cons n (list_n p)  end.
Definition cree_list_n (n : nat) := rev (list_n n).
Eval compute in cree_list_n 6.

Require Import ZArith.
Open Scope Z_scope.

Definition creer_l (n : Z) := iter n (Z*Z) (fun x => match x with (i,l)=>(i+1, cons i l) end) (0,nil).


