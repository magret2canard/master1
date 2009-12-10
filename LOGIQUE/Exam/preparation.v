(** Logique propositionnelle *)

(* indiquer toutes les etapes de la preuve du theoreme ci-dessous *)



Lemma L1: forall P Q, ~(P /\ Q)-> P -> ~Q.



(** Logique du premier ordre *)
(* indiquer les etapes principlaes de la preuve du theoreme ci-dessous 
   (utilisation d'apply, de destruct ou d'exists) *)


Lemma L2 : forall (A:Type) (P : A->Prop) (Q : Prop),
  (forall x:A, P x -> Q) <-> ((exists y:A, P y) -> Q).


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
Admitted.


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
Admitted.


(* On definit le predicat suivant *)

Definition multiple_de_3 (n : nat) := exists p:nat, n = 3 * p.



(* On admet le resultat suivant (demonstration non demandée) : *)
Lemma mult3_inv : forall n, multiple_de_3 n ->
                            n = 0 \/ 
                            exists p, n = 3 + p /\ multiple_de_3 p.
Admitted.

(* Prouver le lemme ci-dessous (on utilisera mult3_inv) *)


Lemma One_not_mult3 : ~multiple_de_3 1.
Admitted.

(* Note : on rappelle que "discriminate H" permet de resoudre tout
but contenant une hypothese H : n = p, ou n et p seont deux entiers
differents.

Par exemple :

Goal  forall n, 2 <> 4+ n.
intros n H;discriminate H.
Qed.

*)
