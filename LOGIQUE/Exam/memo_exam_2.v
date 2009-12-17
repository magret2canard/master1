Lemma L1: forall P Q, ~(P /\ Q)-> P -> ~Q.
  Proof.
  intros P Q.

(*
1 subgoal
P : Prop
Q : Prop
______________________________________(1/1)
~ (P /\ Q) -> P -> ~ Q
*)

  intro H0.

(* 
1 subgoal
P : Prop
Q : Prop
H0 : ~ (P /\ Q)
______________________________________(1/1)
P -> ~ Q
*)

  intro H1.

(*
1 subgoal
P : Prop
Q : Prop
H0 : ~ (P /\ Q)
H1 : P
______________________________________(1/1)
~ Q
*)

  intro H2.

(*
1 subgoal
P : Prop
Q : Prop
H0 : ~ (P /\ Q)
H1 : P
H2 : Q
______________________________________(1/1)
False
*)

  apply H0.

(*
1 subgoal
P : Prop
Q : Prop
H0 : ~ (P /\ Q)
H1 : P
H2 : Q
______________________________________(1/1)
P /\ Q
*)

  split.

(*
2 subgoals
P : Prop
Q : Prop
H0 : ~ (P /\ Q)
H1 : P
H2 : Q
______________________________________(1/2)
P


______________________________________(2/2)
Q
*)

  assumption. assumption.

Qed.