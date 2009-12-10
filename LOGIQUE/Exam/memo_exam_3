(* On definit les fonctions suivantes *)


Fixpoint Le (n p:nat) : bool :=
 match n, p with 0, _ => true
               | S q, S r => Le q r
               | _, _ => false
 end.

Fixpoint Lt (n p:nat) : bool :=
 match n, p with 0, S _ => true
               | S q, S r => Lt q r
               | _, _ => false
 end.

(*   Comment terminer les preuves suivantes *)

Lemma Lt_irr : forall n, Lt n n = false.
Proof.
 induction n.

(*
2 subgoals
______________________________________(1/2)
Lt 0 0 = false


______________________________________(2/2)
Lt (S n) (S n) = false
*)

 simpl.

(*
2 subgoals
______________________________________(1/2)
false = false


______________________________________(2/2)
Lt (S n) (S n) = false
*)

  trivial.

(*
1 subgoal
n : nat
IHn : Lt n n = false
______________________________________(1/1)
Lt (S n) (S n) = false
*)

  simpl.

(*
1 subgoal
n : nat
IHn : Lt n n = false
______________________________________(1/1)
Lt n n = false
*)

  trivial.

Qed.


(**********************************************************************************)

Lemma Le_eq_or_Lt : forall n p, Le n p = true -> n = p \/ Lt n p = true.
 Proof.
 induction n; simpl; auto.
 destruct p;simpl;auto.
 destruct p;simpl;auto.
(*
1 subgoal
  
  n : nat
  IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
  p : nat
  ============================
   Le n p = true -> S n = S p \/ Lt n p = true
*)

  intro H.

(*
1 subgoal
n : nat
IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
p : nat
H : Le n p = true
______________________________________(1/1)
S n = S p \/ Lt n p = true
*)

  destruct (IHn p H).

(*
2 subgoals
n : nat
IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
p : nat
H : Le n p = true
H0 : n = p
______________________________________(1/2)
S n = S p \/ Lt n p = true


______________________________________(2/2)
S n = S p \/ Lt n p = true
*)

  rewrite H0.

(*
2 subgoals
n : nat
IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
p : nat
H : Le n p = true
H0 : n = p
______________________________________(1/2)
S p = S p \/ Lt p p = true


______________________________________(2/2)
S n = S p \/ Lt n p = true
*)

  left.

(*
2 subgoals
n : nat
IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
p : nat
H : Le n p = true
H0 : n = p
______________________________________(1/2)
S p = S p

______________________________________(2/2)
S n = S p \/ Lt n p = true

*)

  trivial.

(*
1 subgoal
n : nat
IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
p : nat
H : Le n p = true
H0 : Lt n p = true
______________________________________(1/1)
S n = S p \/ Lt n p = true
*)

  right.

(*
1 subgoal
n : nat
IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
p : nat
H : Le n p = true
H0 : Lt n p = true
______________________________________(1/1)
Lt n p = true
*)

  assumption.
Qed.
