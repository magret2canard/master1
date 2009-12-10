(** Logique propositionnelle *)

(* indiquer toutes les etapes de la preuve du theoreme ci-dessous *)



Lemma L1: forall P Q, ~(P /\ Q)-> P -> ~Q.
Proof.
 intros P Q H p.
(*

 On a le but suivant :
1 subgoal
  
  P : Prop
  Q : Prop
  H : ~ (P /\ Q)
  p : P
  ============================
   ~ Q
*)

intro q; destruct H.

(*
1 subgoal
  
  P : Prop
  Q : Prop
  p : P
  q : Q
  ============================
   P /\ Q

*)
split;assumption.
Qed.



(** Logique du premier ordre *)

(* indiquer les etapes principlaes de la preuve du theoreme ci-dessous 
   (utilisation d'apply, de destruct ou d'exists) *)

Lemma L2 : forall (A:Type) (P : A->Prop) (Q : Prop),
  (forall x:A, P x -> Q) <-> ((exists y:A, P y) -> Q).
intros A P Q; split ;intro H.

(* on a le sous-but 
  
  A : Type
  P : A -> Prop
  Q : Prop
  H : forall x : A, P x -> Q
  ============================
   (exists y : A, P y) -> Q
*)

intros [y Hy].
apply (H y);assumption.

(** le second but est 

  A : Type
  P : A -> Prop
  Q : Prop
  H : (exists y : A, P y) -> Q
  ============================
   forall x : A, P x -> Q
*)

intros x Hx; apply H.

(*
1 subgoal
  
  A : Type
  P : A -> Prop
  Q : Prop
  H : (exists y : A, P y) -> Q
  x : A
  Hx : P x
  ============================
   exists y : A, P y
*)
exists x;assumption.
Qed.



(** Arithmetique *)


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
 induction n; simpl.

(* 
 le premier sous-but est trivial.

  ============================
   false = false
*)
trivial.
(* Le second aussi 
1 subgoal
  
  n : nat
  IHn : Lt n n = false
  ============================
   Lt n n = false
*)
trivial.
Qed.



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

(* On utilise IHn pour une preuve par cas *)
intro H;destruct (IHn p H).

(* dans le premier cas, on a l'hypothese n = p 

  n : nat
  IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
  p : nat
  H : Le n p = true
  H0 : n = p
  ============================
   S n = S p \/ Lt n p = true
*)
rewrite H0;left;trivial.
(* le second cas est trivial aussi

1 subgoal
  
  n : nat
  IHn : forall p : nat, Le n p = true -> n = p \/ Lt n p = true
  p : nat
  H : Le n p = true
  H0 : Lt n p = true
  ============================
   S n = S p \/ Lt n p = true
*)
right;assumption.
Qed.


(* On definit le predicat suivant *)

Definition multiple_de_3 (n : nat) := exists p:nat, n = 3 * p.



(* On admet le resultat suivant (demonstration non demandée) : *)
Lemma mult3_inv : forall n, multiple_de_3 n ->
                            n = 0 \/ 
                            exists p, n = 3 + p /\ multiple_de_3 p.
Admitted.

(* Prouver le lemme ci-dessous (on utilisera mult3_inv) *)


Lemma One_not_mult3 : ~multiple_de_3 1.
Proof.
 intro H.
 (* on utilise mult3_inv pour avoir deux cas *) 

 destruct (mult3_inv 1 H).
 (*
  H : multiple_de_3 1
  H0 : 1 = 0
  ============================
   False

  on se debarasse de H0 par discriminate
 *)
 discriminate.
 
 (* le second cas se prsente comme ça :
  H : multiple_de_3 1
  H0 : exists p : nat, 1 = 3 + p /\ multiple_de_3 p
  ============================
   False

  On elimine l'existenciel et le ET *)
  destruct H0 as [p Hp];destruct Hp.
  (*1 subgoal
  
  H : multiple_de_3 1
  p : nat
  H0 : 1 = 3 + p
  H1 : multiple_de_3 p
  ============================
   False


  Comme 1 est (S 0) et 3 + p est (S (S (S p))), discriminate H0 va
  terminer la preuve.
*)
 discriminate H0.
Qed.

