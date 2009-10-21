(**
 Mini projet de Coq (INF 462)


 Se fait par groupe de 2 ou 3 d'un meme groupe de TD

 Date de remise :  4 novembre
                   On envoie a) un fichier dont le nom contient au moins
                   un participant du groupe :
                   exemple projet_dupont.v

                   un rapport (format pdf) rapport_dupont.pdf

                   dans un courrier dont le titre contient la chaine de 
                   caracteres  PROJET COQ, adresse a **votre** responsable de
                   TD.


 Le fichier comporte un certain nombre d'Admitted, qu'il s'agit de
 remplacer par des preuves completes.


 
 Que doit contenir le rapport ?
 1) la reponse aux questions a la fin de ce fichier

 2) si une preuve utilise un lemme de la bibliotheque standard, et/ou 
  une tactique  non vue en cours mais trouvée dans la doc, le signaler

 3) des commentaires sur les lemmes ou definitions auxiliaires non demandes
   dans le sujet mais que vous avez trouve utile d'ajouter

 4) Les etapes principales d'une preuve qui vous paraissent interessantes 
 (choix d'une recurrence sur un type de donnee ou un predicat, utilisation 
  d'inversion, injection, etc.)

 5) Les problemes que vous avez rencontres et pourquoi vous n'avez pas su les 
    resoudre.
  

6) En revanche, ne mettez pas dans le rapport les informations qu'on peut 
   trouver dans votre fichier .v  (en le lisant sous coqIde ou Proof-General)
   ce serait du remplissage inutile.
  




FAQ.

 Si vous rencontrez des (vraies) difficultes, ecrivez aux *deux* chargés de
 TD (Frederique Carrere et Pierre Casteran). Les reponses seront ajoutees
 au fichier http://www.labri.fr/~casteran/FM/Logique/FAQ.txt 


*)




Require Import Arith.
Require Import Max.
Require Import ArithRing.
Require Import List.


(* On considere les definitions suivantes *)

Inductive btree(A:Type): Type :=
  leaf : btree A
| bin : A -> btree A -> btree A -> btree A.

Implicit Arguments  leaf [A].
Implicit Arguments  bin [A].


Definition tree_example := bin 6 (bin 7 leaf leaf)
                                 (bin 8 (bin 3 leaf leaf) 
                                        (bin 8 leaf leaf)).

Fixpoint tree_size {A:Type}(t: btree A):=
 match t with leaf => 1
            | bin _ t1 t2 => 1 + tree_size t1 + tree_size t2
 end.


Fixpoint tree_mirror {A:Type}(t: btree A):=
 match t with leaf => leaf
            | bin i t1 t2 => bin i (tree_mirror t2) (tree_mirror t1)
 end.

Eval compute in tree_size tree_example.

Eval compute in tree_mirror tree_example.


(* 1- definir une fonction is_leaf qui retourne true si un arbre est une feuille
                                                false sinon *)

Definition is_leaf {A: Type}(t: btree A) : bool :=
   match t with
      leaf => true
    | _ => false end.

Eval compute in is_leaf tree_example.

(* Vous devrez ensuite prouver le lemme suivant *)


Lemma leaf_is_leaf : forall (A:Type)(t: btree A), 
   is_leaf t = true <-> t = leaf.
Proof.
induction t.
split.
unfold is_leaf.
trivial.
unfold is_leaf.
trivial.
split.
unfold is_leaf.
intros.
discriminate.
intros.
unfold is_leaf.
discriminate.
Qed.



(* 2- Prouver les lemmes suivants *)

Lemma mirror_mirror : forall (A:Type)(t: btree A),
    tree_mirror (tree_mirror t) = t.
Proof.
induction t.
unfold tree_mirror.
trivial.
symmetry.
simpl.
rewrite IHt1.
rewrite IHt2.
trivial.
Qed.

Lemma mirror_size : forall (A:Type)(t: btree A),
    tree_size (tree_mirror t) = tree_size t.
Proof.
induction t.
simpl.
trivial.
simpl.
rewrite IHt1.
rewrite IHt2.
rewrite plus_comm.
trivial.
Qed.


(* 3- On definit les fonctions number_of_bin et number_of_leaves *)

Fixpoint number_of_bin {A:Type}(t: btree A):=
 match t with leaf => 0
            | bin i t1 t2 => 1 + number_of_bin t1 + number_of_bin t2
 end.

Fixpoint  number_of_leaves {A:Type} (t : btree A) : nat :=
  match t with leaf => 1
             | bin r t1 t2 =>  number_of_leaves t1 + number_of_leaves t2
  end.

(* Prouver le lemme suivant *)

Lemma bin_n_leaves : forall (A:Type)(t: btree A), 
            number_of_leaves t = S (number_of_bin t).
Proof.
induction t.
unfold number_of_leaves.
trivial.
simpl.
rewrite IHt1.
rewrite IHt2.
rewrite plus_n_Sm.
simpl.
trivial.
Qed.




(* 4- On definit la fonction tree_to_list *)

Fixpoint tree_to_list {A:Type}(t: btree A) : list A :=
 match t with leaf => nil
            | bin n t1 t2 => tree_to_list t1 ++ (n :: tree_to_list t2)
 end.

(* Prouver le lemme suivant *)

Lemma tree_to_list_length :  forall A (t:btree A),  
    length (tree_to_list t) = number_of_bin t.
Proof.
induction t.
unfold number_of_bin.
unfold tree_to_list.
trivial.
simpl.

symmetry in IHt1.
symmetry in IHt2.
rewrite IHt1.
rewrite IHt2.
rewrite plus_n_Sm.
symmetry.
destruct IHt1.
destruct IHt2.
rewrite plus_n_Sm.
unfold tree_to_list.
simpl.
rewrite plus_Sn_m.
simpl.
unfold tree_to_list.
rewrite IHt2.
unfold length.
simpl.

simpl.
unfold number_of_bin.
simpl.
unfold
rewrite IHt1.
Admitted.



(* 5- on considere la definition suivante *)

Fixpoint tree_fold {A B:Type}(f: A -> B -> B -> B)(b:B) (t : btree A) :=
 match t with leaf => b
            | bin a t1 t2 => f a (tree_fold f b t1)
                                 (tree_fold f b t2)
 end.

(* donner une nouvelle definition de tree_size, tree_to_list , mirror 
   sous la forme suivante 

Definition tree_size' {A:Type}(t : btree A) :=  tree_fold  XXX YYY t
Definition tree_mirror'{A:Type}(t : btree A) := tree_fold TTT UUU t.

prouver que vos nouvelles definitons sont equivalentes aux precedentes.

*)


(* 6- On definit les fonctions the_subtree et Subtree 
      de la maniere suivante: *)


Inductive direction : Set := g (* gauche *) | d (* droite *).
Definition path := list direction.

Fixpoint the_subtree  {A:Type} (p:path)(t: btree A) : btree A :=
    match p, t with nil, _ =>  t
                  |g::p', bin _ t1 _ => the_subtree p' t1
                  |d::p', bin _ _ t2  => the_subtree p' t2
                  | _ ,  _ => leaf
    end.

Definition Subtree {A:Type} (t t': btree A) := 
                exists p, the_subtree p t' = t.

(* Prouver les lemmes suivants *)

Lemma Subtree_refl : forall A (t:btree A), Subtree t t.
Proof.
Admitted.

Lemma the_subtree_app : forall  A p1 p2 (t : btree A),
                          the_subtree (p1 ++ p2) t = 
                          the_subtree p2 (the_subtree p1 t).
Proof.
Admitted.

Lemma Subtree_trans :forall A (t t1 t2:btree A), Subtree t t1->
                                                 Subtree t1 t2 ->
                                                 Subtree t t2.
Proof.
Admitted.


(* 7- Demontrer le lemme suivant *)

Lemma not_left_son_of_itselt : 
   forall (A:Type)(a:A)(t1 t2:btree A), t1 <> bin a t1 t2.
Proof.
Admitted.

(* 8- On considere les definitions suivantes *)

Fixpoint h_l {A:Type}(t:btree A) : nat :=
  match t with leaf => 0
             | bin _ t1 _ => 1 + h_l t1
  end. 

Fixpoint test_aux  {A:Type}(t:btree A)(h:nat) :=
 match t,h with leaf,0 => true
              | bin _ t1 t2, S h' => andb (test_aux t1 h') (test_aux t2 h')
              | _ , _ => false
 end.

Definition test {A:Type}(t:btree A) := test_aux t (h_l t).


(* Dans le rapport, donnez  une caracterisation des arbres t tels
que l'evaluation de test t renvoie true. Expliquez votre reponse.

 On vous demande egalement de prouver vos affirmations (en Coq, bien sur).

 Votre caracterisation prendra la forme d'un predicat 
 
 Caracterisation {A:Type} : btree A -> Prop.

 Il va  de soi qu'une reponse caricaturale n'apportant rien, genre

 Definition Caracterisation {A:Type} (t: btree A) := test t = true.

 ne serait meme pas consideree.

 En revanche, vous pouvez definir les fonctions, predicats et prouver
 les lemmes qui vous paraissent utiles, et commenter vos decisions  dans le
 rapport *)






