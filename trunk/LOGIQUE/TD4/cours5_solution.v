(** COURS N° 5 *)

(** Recurrence, recursivite, et définitions inductives  *)

Require Import Arith.
Require Import ArithRing.
Require Import List.

Fixpoint Le (n p:nat) : bool :=
  match n, p with 0,_ => true
                | S m, S q => Le m q
                | _, _  => false
  end.



Eval compute in Le 45 67.
Eval compute in Le 67 45.


Definition max n p := if Le n p then p else n.
Definition min n p := if Le n p then n else p.

Eval compute in max 42 (19+23).

Fixpoint sum (n:nat) : nat :=
  match  n with 0 => 0 
              | S p => n + sum p
  end.
Eval compute in sum 6.



(** Sur les listes *)

Require Import List.


Fixpoint length {A:Type}(l: list A): nat :=
 match l with nil => 0
            | a::l' => S (length l')
 end.

Fixpoint app (A:Type)(l l':list A) : list A:=
 match l with nil => l'
            | a::l1  => a::(app _ l1 l')
 end.
Implicit Arguments app [A].


Notation "l ++ l'" := (app  l l') : list_scope.


Check app (1::2::3::nil) (4::5::6::nil).
Check fun (A:Type)(l:list A)=> app l l.

Fixpoint rev {A:Type}(l:list A) :=
 match l with nil => nil
            | (a::l') => rev l' ++ (a::nil)
end.

(* preuves simples par recurrence  *)

Lemma Le_n : forall n, Le n n = true.
Proof.
 induction n;simpl.
 trivial.
 trivial.
Qed.

Lemma max_n : forall n, max n n = n.
Proof.
 intro n;unfold max.
 rewrite Le_n.
 trivial.
Qed.


Lemma length_app : forall A (l l':list A), length (l ++ l') =
                                           length l + length l'.
Proof.
 intros A l l';induction l.
 simpl.
 trivial.
 simpl.
 rewrite IHl;auto.
Qed.

Lemma length_rev : forall A (l:list A), length (rev l) = length l.
Proof.
 intros A l;induction l.
 simpl;trivial.
 simpl.
 rewrite length_app.
 rewrite IHl.
 simpl.
 rewrite plus_comm;simpl;auto.
Qed.



Lemma app_assoc : forall (A:Type) (l l1 l2:list A), (l++l1)++l2 = l++(l1++l2).
Proof.
 induction l;simpl;auto.
 intros;rewrite IHl;auto.
Qed.


(* Preuve un peu plus complexe *)

Lemma rev_rev : forall (A:Type) (l:list A), rev (rev l) = l.
Proof.
 intros A l;induction l;simpl; trivial.
 
 Lemma rev_app : forall (A:Type) (l l':list A), rev (l ++ l')=rev l' ++ rev l.
 Proof.
  induction l.
 simpl.

 (* premiere solution *)
 intro l';generalize (rev l') as r.
 induction r;simpl;auto.
 rewrite <- IHr;trivial.
 (* on peut decider de prouver un lemme plus general *)
 Undo 3.  
 
   Lemma app_l_nil : forall (A:Type)(l:list A), l++nil = l.
   Proof.
   induction l;simpl;auto.
 rewrite IHl;trivial.
  Qed.
 
 intro;rewrite app_l_nil;auto.
 intro l'.
 simpl.
 rewrite IHl.
 rewrite app_assoc;trivial.
Qed.

rewrite rev_app.
rewrite IHl.
 trivial.
Qed.


SearchRewrite (rev _).


(* Preuves par cas  (destruct ou case) *)

Lemma max_min : forall n p, max n p = p -> min n p = n.
Proof.
 intros n p;unfold min, max.
 destruct (Le n p).
 trivial.
 intro;symmetry;trivial.
Qed.

Lemma max_min' : forall n p, max n p = p -> min n p = n.
Proof.
 unfold min, max;intros.
 
 case_eq (Le n p).
 trivial.
 intro H0; rewrite H0 in H.
 symmetry;trivial.
Qed.

Lemma max_min'' : forall n p, max n p = p -> min n p = n.
Proof.
 unfold min, max;intros.
 generalize H.
 clear H.
 destruct (Le n p).
 trivial.
 symmetry;auto.
Qed.


(* Preuves plus complexes *)
 
Lemma Le_Sn_Sp : forall n p, Le (S n) (S p) = Le n p.
Proof.
 induction n. 
 destruct p. 
 simpl;trivial.
 simpl;trivial.
 destruct p.

 simpl;trivial.
 
 simpl.
 reflexivity.


(* one liner *)
Restart.
 induction n; destruct p; simpl; trivial.
 
Qed.
 

Lemma Le_S : forall n p, Le n p = true -> Le n (S p) = true.
Proof.
 induction n;destruct p;simpl;trivial.
 intro H;discriminate.
 apply IHn.
Qed.


Lemma Le_antisym : forall n p, Le n p = true -> Le p n = true -> n = p.
Proof.
 induction n;destruct p;simpl;auto.
 intros;discriminate.
 intros;discriminate.
Qed.



Lemma Le_trans :  forall n p q , Le n p = true -> Le p q = true ->  
                                 Le n q = true.
Proof.
 induction n;destruct p;simpl;auto.
  intros;discriminate.
 destruct q.
 intros;discriminate.
 apply IHn.
Qed.


Definition LE (n p:nat) := exists q:nat, q+n =p.

Lemma Le_LE : forall n p, Le n p=true -> LE n p.
Proof.
 induction n ;destruct p;simpl.
 exists 0;auto.
 exists (S p);auto.
 intro;discriminate.
 intro H;destruct (IHn _ H).
 exists x.
 rewrite plus_comm.
 simpl;rewrite plus_comm;auto.
Qed.

Lemma LE_Le : forall n p, LE n p -> Le n p = true.
Proof.
 intros n p H;destruct H as [q Hq].
 induction q.
 simpl in Hq;rewrite Hq.
 apply Le_n. (* mal parti !! *)
 Restart.
 intros n p H;destruct H as [q Hq].
 generalize q n p Hq;clear Hq.
 induction q0.
 intros;simpl in *.
 subst n0;apply Le_n.
 
 intros n0 p0.
 destruct p0. 
 simpl;intro;discriminate.
 intro H.
 generalize (IHq0 n0 p0).
intro H0;apply Le_S.
 apply H0.
 simpl in H.
 injection H.
trivial.
Qed.

Lemma Le_eq_LE : forall n p, Le n p = true <-> LE n p. 
Proof.
 intros n p;split;intro H;[apply Le_LE | apply LE_Le];assumption.
Qed.

Goal LE 3 502.
rewrite <- Le_eq_LE.
trivial.
Qed.




Fixpoint fast_rev_aux {A} (l l':list A) : list A :=
  match l with nil => l'
             | a::l1 => fast_rev_aux l1 (a::l')
end.


Definition fast_rev {A:Type}(l:list A) := fast_rev_aux l nil.

Lemma fast_rev_ok : forall  A (l:list A), rev l = fast_rev l.

 induction l.
 unfold fast_rev; simpl;trivial.
 unfold fast_rev in *.
 simpl.

 rewrite IHl.
 Restart.
 unfold fast_rev.
 intro A.
  (*
  assert(forall l l':list A, rev l ++ l' = fast_rev_aux l l').
 *)

 intro l; replace (rev l) with (rev l ++ nil).
 generalize l (@nil A).
 induction l0;simpl;auto.

 intro l1. 
 rewrite app_assoc. rewrite IHl0.
 simpl.
 trivial.
 SearchRewrite (_ ++ nil).
 rewrite app_l_nil.
 trivial.
Qed.

(* exercices *)

(* on définit les fonctions suivantes *)
Section A_declared.

Variable A:Type.
Variable eq_b : A -> A -> bool.

Hypothesis eq_b_OK : forall a b, eq_b a b=true <-> a = b.
Fixpoint nth (n:nat)(l:list A) : option A :=
 match n, l with _,nil => None
            |    0,a :: l'=> Some a
            |    S p, _::l' => nth p l'
 end.

Fixpoint mem (a:A)(l:list A) : bool :=
  match l with nil => false
             | b::l' => if eq_b a b then true else mem  a l'
  end.


(* On essaie de prouver ceci : *)
Lemma mem_ok_1 : forall  (a:A)(n:nat)(l:list A), nth n l = Some a ->
                                                 mem  a l = true.
induction n.
destruct l.
simpl.
intro;discriminate.

simpl.
intro H;injection H.
intro e;rewrite e.

case_eq (eq_b  a a).
auto.
intro.
assert (eq_b a a = true).
rewrite eq_b_OK;auto.
rewrite H1 in H0;discriminate.
destruct l;simpl.
intro;discriminate.
case_eq (eq_b a a0).
auto.
auto.
Qed.


Lemma mem_ok_2 : forall  (a:A)(l:list A), mem  a l = true ->
                                          exists n, nth n l = Some a.
Proof.
 induction l.
 simpl.
 intro;discriminate.
  simpl.
 case_eq (eq_b a a0).
 intros;exists 0.
 simpl.
 rewrite eq_b_OK in H.
rewrite H;auto.
 intros.
 simpl.
 destruct (IHl H0) as [p Hp].
 exists (S p);simpl.
 auto.
Qed.

                                                 
(* Enoncer et prouver une reciproque de mem_ok_1 *)

End A_declared.
Implicit Arguments nth [A].
Implicit Arguments mem [A].



Eval compute in mem beq_nat 5 (3::4::51::nil).



                                                 

