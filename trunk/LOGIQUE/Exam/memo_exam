Lemma L2 : forall (A:Type) (P : A->Prop) (Q : Prop),
  (forall x:A, P x -> Q) <-> ((exists y:A, P y) -> Q).
  Proof.
  intros A P Q.
(* 
1 subgoal
A : Type
P : A -> Prop
Q : Prop
______________________________________(1/1)
(forall x : A, P x -> Q) <-> (exists y : A, P y) -> Q 
*)

  split.

(* 
2 subgoals
A : Type
P : A -> Prop
Q : Prop
______________________________________(1/2)
(forall x : A, P x -> Q) -> (exists y : A, P y) -> Q


______________________________________(2/2)
((exists y : A, P y) -> Q) -> forall x : A, P x -> Q 
*)

  intro H.
(*
2 subgoals
A : Type
P : A -> Prop
Q : Prop
H : forall x : A, P x -> Q
______________________________________(1/2)
(exists y : A, P y) -> Q
*)
  intros [y Hy].

(*
2 subgoals
A : Type
P : A -> Prop
Q : Prop
H : forall x : A, P x -> Q
y : A
Hy : P y
______________________________________(1/2)
Q
*)
  apply (H y).

(*
2 subgoals
A : Type
P : A -> Prop
Q : Prop
H : forall x : A, P x -> Q
y : A
Hy : P y
______________________________________(1/2)
P y

*)
 assumption.


(*
1 subgoal
A : Type
P : A -> Prop
Q : Prop
______________________________________(1/1)
((exists y : A, P y) -> Q) -> forall x : A, P x -> Q
*)

  intro H.

(*
1 subgoal
A : Type
P : A -> Prop
Q : Prop
H : (exists y : A, P y) -> Q
______________________________________(1/1)
forall x : A, P x -> Q
*)
  
  intros x Hx.
  
(*
1 subgoal
A : Type
P : A -> Prop
Q : Prop
H : (exists y : A, P y) -> Q
x : A
Hx : P x
______________________________________(1/1)
Q
*)
  apply H.
(*
1 subgoal
A : Type
P : A -> Prop
Q : Prop
H : (exists y : A, P y) -> Q
x : A
Hx : P x
______________________________________(1/1)
exists y : A, P y
*)
  exists x.

(*
1 subgoal
A : Type
P : A -> Prop
Q : Prop
H : (exists y : A, P y) -> Q
x : A
Hx : P x
______________________________________(1/1)
P x
*)
 assumption.

Qed.