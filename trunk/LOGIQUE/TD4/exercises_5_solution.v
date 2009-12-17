(** This first serie of  exercises asks you to prove some derived
    inference rule. For some of them, build a small example of its application. 


First, let us look at some example : *)

Lemma P3Q : forall P Q : Prop, (((P->Q)->Q)->Q) -> P -> Q.
Proof.

 intros P Q H p.
 apply H. 
 intro H0;apply
 H0;assumption. 
Qed.

Lemma triple_neg : forall P:Prop, ~~~P -> ~P.
Proof.
 intros P ;unfold not; apply P3Q.
Qed.



Lemma not_or_1 : forall P Q : Prop, ~(P \/ Q) -> ~P.
Proof.
  intros P Q H H0; apply H;left;assumption.
Qed.
 
Section not_or_1_example.
 Variable n : nat.
 Hypothesis H : n=0 \/ n =2 -> n <> n.
 
 Lemma L1 : ~n=0.
 Proof.
 apply not_or_1 with (n=2).
 intro H0. 
 apply H;auto.
 Qed.

 End not_or_1_example.



Lemma de_morgan_1 : forall P Q: Prop, ~ (P \/ Q) <-> ~P /\ ~Q.
Proof.
 intros P Q;split.
 intro H ;split; intro H0;destruct H;auto.
 intros [p' q'] [p | q].
 destruct p';assumption.
 destruct q';assumption.
Qed.

Lemma de_morgan_2 : forall P Q: Prop, ~ P \/ ~Q  -> ~(P /\ Q).
Proof. 
 intros P Q [p' | q'] [p q];[destruct p'|destruct q'];assumption.
Qed.

Lemma test : forall (A:Type) (P:A->Prop) (x:A), (forall x:A, P x) -> P x.
Proof.
intros A P x.
intro H.
apply H.


Lemma all_perm :
 forall (A:Type) (P:A -> A -> Prop),
   (forall x y:A, P x y) -> 
   forall x y:A, P y x.
Proof.
 intros A P H x y;apply H.
Qed.

Lemma resolution :
 forall (A:Type) (P Q R S:A -> Prop),
   (forall a:A, Q a -> R a -> S a) ->
   (forall b:A, P b -> Q b) -> 
   forall c:A, P c -> R c -> S c.
Proof.
 intros A P Q R S H H0 c H1 H2;apply H.
 apply H0;assumption.
 assumption.
Qed.



Lemma not_ex_forall_not : forall (A: Type) (P: A -> Prop),
                      ~(exists x, P x) <-> forall x, ~ P x.
Proof.
 intros A P;split.
 intros H x Hx. destruct H. exists x;assumption.
 intros H [x Hx].
 destruct (H x). assumption.
Qed.

Lemma ex_not_forall_not : forall (A: Type) (P: A -> Prop),
                       (exists x, P x) -> ~ (forall x, ~ P x).
Proof.
 intros A P [x Hx] H.
 destruct (H x).
 assumption.
Qed.

Lemma diff_sym : forall (A:Type) (a b : A), a <> b -> b <> a.
Proof.
 intros A a b H e . destruct H.
 symmetry;assumption.
Qed.


Lemma fun_diff :  forall (A B:Type) (f : A -> B) (a b : A), 
                       f a <> f b -> a <> b.
Proof.
 intros A B f a b H e.
 destruct H. rewrite e. reflexivity.
Qed.

(**  this exercise deals with five equivalent characterizations of 
     classical logic 

   Some  solutions may use the following patterns :
    unfold Ident [in H].
    destruct (H t1 ... t2)
    generalize t.
    exact t.

   Please look at Coq's documentation before doing these exercises *)

Definition Double_neg : Prop := forall P:Prop, ~~P -> P.

Definition Exm : Prop := forall P : Prop, P \/ ~P.

Definition Classical_impl : Prop := forall P Q:Prop, (P -> Q) -> ~P \/ Q.

Definition Peirce : Prop := forall P Q : Prop, ((P -> Q) -> P) -> P.

Definition Not_forall_not_exists : Prop :=
           forall (A:Type)(P:A->Prop), ~(forall x:A, ~P x) -> ex P.

Lemma  Exm_Double_neg : Exm -> Double_neg.
Proof.
 unfold Double_neg.
 intros H P.
 destruct (H P) as [p | p'].
 intro;assumption.
 intro H1. destruct H1. assumption.
Qed.


Lemma Double_neg_Exm :  Double_neg -> Exm.
Proof.
 intros H P.
 apply H.
 intro H0.
 assert (H1: ~P).
 intro p;destruct H0;auto.
 destruct H0;auto.
Qed.


Lemma Peirce_Double_neg : Peirce -> Double_neg.
Proof.
 intros H P H0.
  unfold Peirce in H.
 apply H with False.
 intro H1;destruct H0;assumption.
Qed.

Lemma Exm_Peirce : Exm -> Peirce.
Proof.
 intros H P Q.
 intro H0;destruct (H P) as [p | p'];auto.
 apply H0;intro p;destruct p';assumption. 
Qed.


Lemma Classical_impl_Exm : Classical_impl -> Exm.
Proof.
 intros H P. red in H.
 destruct (H P P) as [p | p'].
 auto.
 right;assumption.
 left;assumption.
Qed.

 
Lemma Exm_Classical_impl : Exm -> Classical_impl.
Proof.


 intros H P Q H0.
 unfold Exm in H.
 destruct (H P) as [p | p'].
 right;auto.
 auto.
Qed.
 
 
Lemma Not_forall_not_exists_Double_neg :  Not_forall_not_exists -> Double_neg.
Proof.
 intros H P;red in H.


 intro H0;destruct (H nat (fun n => P)) as [x Hx].
 intro H1. destruct H0.
 apply H1. exact 0.
 assumption.
Qed.


Lemma Exm_Not_forall_not_exists: Exm -> Not_forall_not_exists.
Proof.
 intros H A P H0.
 destruct (H (ex  P)).

auto.
 destruct H0;intros x Hx.
 destruct H1. exists x. assumption.
Qed.



(** Consider the following definitions (which could be found in the standard 
   library *)

Section On_functions.
Variables (U V W : Type).

Variable g : V -> W.
Variable f : U -> V.

 Definition injective : Prop := forall x y:U, f x = f y -> x = y.
 Definition surjective : Prop := forall v : V, exists u:U, f u = v.

Lemma injective' : injective -> forall x y:U, x <> y -> f x <> f y.
Proof.
 intros Hi x y d e.
 destruct d;apply Hi;assumption.
Qed.

Definition compose := fun u : U => g (f u).

End On_functions.
Implicit Arguments compose [U V W].
Implicit Arguments injective [U V].
Implicit Arguments surjective [U V].

Lemma injective_comp : forall U V W (f:U->V)(g : V -> W),
                       injective (compose g f) -> injective f.
Proof.
 intros U V W f g Hi x y e.
 generalize (Hi x y).
 intro H;apply H.
 unfold compose;rewrite e.
 reflexivity.
Qed.


Lemma surjective_comp : forall U V W (f:U->V)(g : V -> W),
                       surjective (compose g f) -> surjective g.
Proof.
 intros U V W f g Hs y.
 destruct (Hs y) as [x Hx].
 exists (f x);assumption.
Qed.


Lemma comp_injective : forall U V W (f:U->V)(g : V -> W),
                       injective f -> injective g -> injective (compose g f).
Proof.
 intros U V W f g Hf Hg x y e.
 generalize (Hf x y) ;intro H1; apply H1.
 apply Hg;assumption.
Qed.

Fixpoint iterate (A:Type)(f:A->A)(n:nat) {struct n} : A -> A :=
 match n with 0 => (fun a => a)
            | S p => fun a => f (iterate _ f p a) 
 end.

 Lemma iterate_inj : forall U (f:U->U) , 
                      injective f ->
                      forall n: nat, injective   (iterate _ f n).
Proof.
 induction n;simpl.
 intros x y e;assumption.
 intros x y e.
 apply IHn.
 apply H;assumption.
Qed.
 

(** Last serie of exercises : Consider the following definitions
   See "impredicatve definitions" in the book *)

Definition my_False : Prop := forall P:Prop, P.

Definition my_not (P:Prop) := P -> my_False.

Definition my_or (P Q:Prop): Prop := forall R:Prop, 
                                    (P-> R) ->(Q->R) -> R.

Definition my_and (P Q:Prop): Prop := forall R:Prop, 
                                    (P-> Q-> R) -> R.

Definition my_exists (A:Type)(P:A->Prop) : Prop :=
  forall R: Prop, 
    (forall a: A, P a -> R) -> R.

Lemma my_False_ok : False <-> my_False.
Proof.
 split;intro H.
 destruct H.
 apply H.
Qed.

Lemma my_or_intro_l : forall P Q:Prop, P -> my_or P Q.
Proof.
 intros P Q p R H H0;apply H;assumption.
Qed.

Lemma my_or_ok : forall P Q:Prop, P \/ Q <-> my_or P Q.
Proof.
 split.
 intros [p | q] R H H0;auto.
 intro H;apply H.
 left;assumption.
 right;assumption.
Qed.

Lemma my_and_ok :  forall P Q:Prop, P /\ Q <-> my_and P Q.
Proof.
 split.
 intros [p q] R H;apply H;assumption.
 intro H;apply H.
 split;assumption.
Qed.

Lemma my_ex_ok :  forall (A:Type)(P:A->Prop),
                   (exists x, P x) <-> (my_exists A P).
Proof.
 intros A P ; split.
 intros [x Hx] R H.
 apply H with x;assumption.
 intro H;apply H.
 intros a Ha;exists a;assumption.
Qed.




 




 

 

                         
  
