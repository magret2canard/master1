(** This file contains some lemmas you will have to prove, i.e. replacing
   the "Admitted" joker with a sequence of tactic calls, terminated with a 
   "Qed" command.

   Each lemma should be proved several times :
   first using only elementary tactics :
   intro[s], apply, assumption
   split, left, right, destruct.
   exists, rewrite
   assert (only if you don't find another solution)


   Then, use tactic composition, auto, tauto, firstorder.


Notice that, if you want to keep all solutions, you may use various 
identifiers like in the given example : imp_dist, imp_dist' share
the same statement, with different interactive proofs.
*)




Section Minimal_propositioal_logic.
 Variables P Q R S : Prop.

 Lemma imp_dist : (P -> Q -> R) -> (P -> Q) -> P -> R.
 Proof.
  intros H H0 p.
  apply H.
  assumption.
  apply H0.
  assumption.
 Qed.

  Lemma imp_dist' : (P -> Q -> R) -> (P -> Q) -> P -> R.
  Proof.
   intros H H0 p;apply H.
   assumption.
   apply H0;assumption.
  Qed.

 Lemma id_P : P -> P.
 Proof.
  intro H.
  assumption.
 Qed.

 Lemma id_P' : P -> P.
 Proof.
  intro H;assumption.
 Qed.

 Lemma id_PP : (P -> P) -> P -> P.
 Proof.
   intros H p;assumption.
Qed.
 
 Lemma imp_trans : (P -> Q) -> (Q -> R) -> P -> R.
 Proof.
  intros H H0 p;apply H0.
  apply H;assumption.
 Qed.


 Lemma imp_perm : (P -> Q -> R) -> Q -> P -> R.
 Proof.
  intros H q p;apply H;assumption.
Qed.


 Lemma ignore_Q : (P -> R) -> P -> Q -> R.
 Proof.
  intros H p _; apply H;assumption.
 Qed.

 Lemma delta_imp : (P -> P -> Q) -> P -> Q.
 Proof.
  intros H p; apply H;assumption.
 Qed.

 Lemma delta_impR : (P -> Q) -> P -> P -> Q.
 Proof.
  intros H p _;apply H;assumption.
 Qed.

 Lemma diamond : (P -> Q) -> (P -> R) -> (Q -> R -> S) -> P -> S.
 Proof.
  intros H H0 H1 p;apply H1;[apply H | apply H0];assumption.
 Qed.


 Lemma weak_peirce : ((((P -> Q) -> P) -> P) -> Q) -> Q.
 Proof.
  intro H;apply H.
  intro H0.
  apply H0.
  intro p;apply H;intro H2.
  assumption.
Qed.

End Minimal_propositioal_logic.


(** Same exercise as the previous one, with full intuitionistic propositional
   logic 

   You may use the tactics intro[s], apply, assumption, destruct, 
                           left, right, split and try to use tactic composition *)


Section propositional_logic.

 Variables P Q R S T : Prop.

 Lemma and_assoc : P /\ (Q /\ R) -> (P /\ Q) /\ R.
 Proof.
  intro H;destruct H as [p [q r]];split.
  split;assumption.
  assumption.
Qed.

 Lemma and_imp_dist : (P -> Q) /\ (R -> S) -> P /\ R -> Q /\ S.
 Proof.
  intros H H0;destruct H as [H1 H2].
  destruct H0 as [p r].
  (*

   intros [H1 H2] [p r].
  *)
  split;[apply H1|apply H2];assumption.
 Qed.
  

 Lemma not_contrad :  ~(P /\ ~P).
 Proof.
  intros [H1 H2];destruct H2;assumption.
 Qed.


 Lemma or_and_not : (P \/ Q) /\ ~P -> Q.
 Proof.
  intros [[p|q] p'].
  destruct p';assumption.
  assumption.
 Qed.

 Lemma not_not_exm : ~ ~ (P \/ ~ P).
 Proof.
  intro H.
  assert (H0: ~P).
  intro p;destruct H;left; assumption.
  destruct H;right;assumption.
 Qed.

 Lemma de_morgan_1 : ~(P \/ Q) -> ~P /\ ~Q.
 Proof.
  intros H;split;intro H0;destruct H.
  left;assumption.
  right;assumption.
 Qed.

 Lemma de_morgan_2 : ~P /\ ~Q -> ~(P \/ Q).
 Proof.
   intros [H H0] [H1 | H1].
   destruct H;assumption.
   destruct H0;assumption.
Qed.

 Lemma de_morgan_3 : ~P \/ ~Q -> ~(P /\ Q).
 Proof.
   intros [H | H] [p q];destruct H;assumption.
 Qed.
 
End propositional_logic.

Section First_Order_Logic.

 Variable A : Set.
 Variables (P Q : A -> Prop)
           (R : A -> A -> Prop).

 
Lemma forall_imp_dist : (forall x:A, P x -> Q x) ->
                        (forall x:A, P x) ->
                        forall x: A, Q x.
Proof.
 intros H H0 x; apply H;apply H0.
Qed.


Lemma forall_perm : (forall x y:A, R x y) -> forall y x, R x y.
Proof.
 intros H x y;apply H.
Qed.


Lemma forall_delta : (forall x y:A, R x y) -> forall x, R x x.
Proof.
  intros H x;apply H.
Qed.


Lemma exists_or_dist : (exists x: A, P x \/ Q x) <->
                       (exists x, P x) \/ (exists x , Q x).
Proof.
 split.
  intros [x [Hp | Hq]].
  left;exists x;assumption.
  right;exists x;assumption.
  intros [[x Hp] | [x Hq]];exists x;auto.
Qed.

Lemma exists_imp_dist : (exists x: A, P x -> Q x) ->
                        (forall x:A, P x) ->
                        exists x:A, Q x.
Proof.
 intros [x Hx] H0;exists x;apply Hx;apply H0.
Qed.

Lemma not_empty_forall_exists : forall a:A,  
                                 (forall x:A, P x) ->
                                  exists x:A, P x.
Proof.
 intros a H;exists a;apply H.
Qed.
                                
Lemma not_ex_forall_not : ~(exists x:A, P x) <-> forall x:A, ~P x.
Proof.
 split.
 intros H x H0;destruct H;exists x;assumption.
 intros H [x Hx].
 (*
 assert (H0 : ~ P x).
 apply H.
 destruct H0;assumption.
 *)
 destruct (H x);assumption.
Qed.

Lemma singleton_forall_eq : (exists x:A, forall y:A, x = y) ->
                            forall z t : A, z = t.
Proof.
 intros [x Hx] z t.
 transitivity x.
 symmetry;apply Hx.
 apply Hx.
Qed.

Section S1.
Variables  (f g : A -> A).

Hypothesis f_g_perm : forall x:A, f (g x) = g (f x).

Hypothesis g_idempotent : forall x : A, g (g x) = g x.
Hypothesis f_idempotent : forall x : A, f (f x) = f x.


Lemma L : forall z, g (f (g (f (g (f z))))) = f (g z).
Proof.
 intro z; repeat rewrite f_g_perm.
 repeat rewrite f_idempotent.
  repeat rewrite g_idempotent.
 reflexivity.
Qed.


Lemma L':  (forall x : A, ~ x = f x) ->
           ~ (exists y : A, True).
Proof.
 intros H [y _].
 destruct (H (f y)).
 symmetry;auto.
Qed.

End S1.

