(* Au prealable : coqc cours5 --> cours5.vo *)


Require Import cours5.
Import List.
Import Arith.

(* ce qui suit est deja dans la bibliotheque standard *)

(*
Inductive le (n:nat) : nat -> Prop :=
le_n : le n n
|le_S : forall p:nat, le n p -> le n (S p).

Notation "n <= p" := (le n p).

Definition lt (n p:nat) := S n <= p.

Notation "n < p" := (lt n p).
*)


Goal 4 <= 6.
constructor 2.
constructor 2.
constructor 1.
Qed.

Inductive prefix {A:Type}: list A -> list A -> Prop :=
 prefix_nil : forall l, prefix nil l
| prefix_cons: forall a l l', prefix l l' -> prefix (a::l) (a::l').

Goal prefix (1::2::3::nil) (1::2::3::4::5::6::nil).
Proof.
 repeat constructor 2.
 constructor 1.
Qed.


(* properties of le *)

Lemma le_0_n : forall n, 0 <= n.
Proof.
 induction n.
 left.
 right.
 assumption.
Qed.

Check le_ind.


Lemma le_Sn_Sp : forall n p, n <= p -> S n <= S p.
Proof.
 intros n p H.
 induction H.
 left.
 right.
 assumption.
Qed.

  Lemma lt_le : forall n p, n < p -> n <= p.
 Proof.
   intros n p H;unfold lt in H.
   induction H.
   right;left.
 right;assumption.
 Qed.

Lemma le_trans : forall n p q, n <= p -> p <= q -> n <= q.
Proof.
 intros n p q H;induction H.
 trivial.
 intro H0;apply IHle.
 fold (lt m q) in H0.
 apply lt_le;trivial.
Qed.

Lemma le_LE : forall n p, n <= p -> LE n p.
Proof.
 intros n p H;induction H.
 Search LE.
 exists 0.
 simpl;auto.
 destruct IHle.
 exists (S x).
 simpl;rewrite H0;trivial.
Qed.

Lemma le_plus : forall n p, n <= n + p.
Proof.
 induction n;simpl.
 apply le_0_n.
 intros; apply le_Sn_Sp.
 apply IHn.
Qed.

Lemma LE_le : forall n p, LE n p -> n <= p.
Proof.
 intros n p [q Hq].
 rewrite <- Hq.
 rewrite plus_comm;apply le_plus.
Qed.


Lemma Le_n_0 : forall n, n <= 0 -> n = 0.
Proof.
 intros n H;induction H.
auto.
(* ????? *)
Restart.
intros n H;inversion H.
trivial.
Qed.



 Lemma le_S_S_inv : forall n p, S n <= S p -> n <= p.
 Proof.
  intros n p H;inversion H.
  left.
  apply le_trans with (S n).
 right;left.
 assumption.
Qed.

Lemma how_inversion_works : 
   forall n p, n <= p ->
               n = p \/
               exists q:nat, p = S q /\ n <= q.
Proof.
 intros n p H;induction H.
 left;trivial.
 destruct IHle;right.
 subst m. exists n;split;trivial.
 destruct H0 as [x Hx].
 exists m;split;trivial.
Qed.

Lemma le_n_0' : forall n, n <= 0 -> n = 0.
Proof. 
  intros n H;destruct (how_inversion_works _ _ H).
  auto.
  destruct H0 as [x [H1 H2]].
  discriminate.
Qed.


Lemma lt_irrefl : forall n, ~ n < n.
Proof.
 unfold not; intros n H.
 (* 
 induction H 
 *)
 (* inversion H.
 *)
 Restart.
 unfold not, lt;induction n.
 intro.
 inversion H.
 intros.
 inversion H.
  Lemma S_diff : forall n, S n <> n.
  Proof.
   induction n.
   discriminate.
   intro H;injection H.
 intro;contradiction.
 Qed.

 destruct (S_diff n);assumption.
 apply IHn.
 apply le_trans with (S (S n)).
 right;left.
 assumption.
Qed.

Lemma le_antisym : forall n p, n <= p -> p <= n -> n = p.
Proof.
 induction n;destruct p.
 trivial.
 intros _ H;inversion H.
 intro H;inversion H.
 

intros H H0. 
rewrite (IHn p).
trivial.
apply le_S_S_inv;assumption.
apply le_S_S_inv;assumption.
Qed.

SearchAbout Le.

SearchAbout LE.

Lemma le_equiv_Le : forall n p, Le n p = true <-> n<=p.
Proof.
 split;intro H.
 apply LE_le.
 apply Le_LE; trivial.
 SearchAbout Le.
apply LE_Le.
 apply le_LE.
 trivial.
Qed.

Goal 2 < 101.
unfold lt;rewrite <- le_equiv_Le.
compute.
trivial.
Qed.

Goal forall n p, n <= p -> max n p = p.
Proof.
 unfold max.
 intros  n p;case_eq (Le n p).
 trivial.
 intros  H H0.
 replace (Le n p) with true in H.
 discriminate.
 symmetry;rewrite le_equiv_Le;trivial.
Qed.
 
(* back to lists *)

Lemma prefix_refl : forall A (l:list A), prefix l l.
Proof.
 induction l.
 left.
 right;trivial.
Qed.

(* TD n° 6 *)


Lemma prefix_of_nil : forall A (l:list A), prefix l nil -> l = nil. 
Proof.
Admitted.


Lemma prefix_trans : forall A (l l1 l2:list A), prefix l l1 -> 
                                                prefix l1 l2 ->
                                                prefix l l2.
Proof.
 intros A l l1 l2 H. 
 generalize l2;induction H.
Admitted.

Lemma prefix_cons_inv : forall (A:Type)(a:A) l l', 
                prefix (a::l) (a::l') -> prefix l l'.
intros A a l l' H;inversion H.
auto.
Qed.

Lemma prefix_app : forall A (l l': list A), prefix l (l++l').
Proof.
Admitted.

Lemma app_prefix : forall A (l l': list A), prefix l l' -> 
                    exists l'', l' = l++l''.
Admitted.

Inductive sorted : list nat -> Prop :=
  sorted_0 : sorted nil
| sorted_1: forall n, sorted (n::nil)
| sorted_2 : forall n p l, n <= p -> sorted (p::l) -> sorted (n::p::l).

Fixpoint  Sorted_aux (n:nat) (l:list nat) : bool :=
 match l with nil => true
            |  p::l' => if Le n p then Sorted_aux p l'
                                 else false
 end.

Eval compute in Sorted_aux 3 (3::2::4::nil).
   
Definition Sorted l := match l with nil => true
                                  | a::l' => Sorted_aux a l'
                       end.

Lemma Sorted_aux_ok : forall l a, sorted (a::l) -> Sorted_aux a l = true.
Admitted.


 
Lemma Sorted_aux_ok_R : forall l a,  Sorted_aux a l = true -> sorted (a::l).
Proof.
Admitted.


Hint Resolve Sorted_aux_ok_R Sorted_aux_ok.
Hint Constructors sorted.
Theorem Sorted_OK : forall l, Sorted l = true <-> sorted l.
Proof.
  destruct l;split;auto.
  unfold Sorted;auto.
Qed.




