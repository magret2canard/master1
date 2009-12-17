(*---------------------------- Cours 1 ----------------------------*)
Definition rep2 (f : nat -> nat)(x:nat) := f (f x).

Definition add3 (x : nat) := x + 3.

Eval compute in rep2 add3 0.

Eval compute in (fun (x : nat) => x + 3) 1.


Check fun v : nat * nat =>

Eval compute in (fun v : nat * nat => match v with (x, y) => x + y end) (3, 4).

Definition couple (v : nat * nat) := match v with (x, y) => x + y end.

Require Import Arith. 
Open Scope nat_scope.


Require Import ZArith. 
Open Scope Z_scope.

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

(*---------------------------- Cours 2 ----------------------------*)

Inductive month : Type := Jan | Feb | Mar | Apr | May | Jun

Check Jan.

Definition nbdays (m:month) := match m with

Eval compute in nbdays Jan.

Inductive i_plane : Type := point (x y : Z).

Definition point_x (p : i_plane) : Z := match p with point x _ => x end.

Definition point_y (p : i_plane) : Z := match p with point _ y => y end.

Definition p1 := (point 1 4).

Eval compute in point_x (point 2 0).

Eval compute in point_y p1.

Require Import String.

Inductive t1 : Type := c1t1 (n : Z)(p : nat)

Definition ft1 (v : t1) : Z := match v with c1t1 _ s => Z_of_nat s 
                                          | c2t1 n => Z_of_nat n end.

Definition a := c1t1 3 4.
Eval compute in ft1 a.

Definition b := c2t1 5.
Eval compute in ft1 b.

Require Import Arith.
Open Scope nat_scope.

Definition prec (n : nat) := match n with 0 => 0
                                        | S p => p end.

Eval compute in prec 3.

Inductive btz : Type := Nbtz (x : Z) (t1 t2 : btz) | Lbtz.

  match t with
      | Lbtz => 0 end.

(*         3         *)
(*        / \        *)
(*       2   1       *)
(*      /            *)
(*     0             *)

Definition arbre1 := (Nbtz 3 (Nbtz 2 (Nbtz 0 Lbtz Lbtz) Lbtz) (Nbtz 1 Lbtz Lbtz)).
Definition arbre2 := Nbtz 0 Lbtz Lbtz.

Eval compute in btz_size arbre2.

Require Import ZArith. 
Open Scope Z_scope.

Fixpoint btz_somme (t : btz) :=
  match t with
     Nbtz n t1 t2 => n + btz_somme t1 + btz_somme t2
   | Lbtz => 0 end.

Eval compute in btz_somme arbre1.

Inductive bt (A : Type) : Type := Nbt (x : A) (t1 t2 : bt A) | Lbt.

Implicit Arguments Lbt [A].

Definition arbre3 := Nbt 3 Lbt Lbt.

Fixpoint dispatch (A : Type) (l : list A) : list A * list A :=
         nil => (nil, nil)
  | a::b::tl => let (l1, l2) := dispatch A tl in (a::l1, b::l2) end.

Eval compute in dispatch Z (1::3::2::4::5::nil).

Inductive option (A : Type) : Type := Some : A -> option A

Eval compute in option Z->Z->nat.


