Require Import ZArith List.
Open Scope Z_scope.


(* Define a datatype of binary trees where non-atomic nodes have only two
  components which are binary trees, and only atomic nodes carry an integer
  value.  Include a case for empty trees. *)

Inductive bt : Type := sous_ab (g d : bt) 
                     | feuille (valeur:Z)
                     | vide.

(*       _        *)
(*     _/ \       *)
(*    / \  3      *)
(*   1   2        *)
Definition arbre1 := (sous_ab (sous_ab (feuille 1) (feuille 2)) (feuille 3)).


(* Define a function that takes a list as input and constructs a balanced
  binary tree carrying the same values.  The trick is to interchange the
  the two components of each node after inserting an integer into the first
  node. *)

Fixpoint insert_bt (x : Z) (t : bt) : bt :=
  match t with
    vide => feuille x
  | feuille y => sous_ab (feuille x) (feuille y)
  | sous_ab t1 t2 =>  sous_ab t2 (insert_bt x t1)
  end.

Definition listToBt : list Z -> bt := 
   fold_right insert_bt vide.

(* Define a function with three arguments: a natural number and two
  lists, which builds a new list by always taking the least element
  of the heads of the two lists.  The length of the resulting list should
  be the natural number given as first input (if the two lists are long enough).

  This is a merge function as in the "merge sort" algorithm, except that the
  natural number argument should be the sum of the lengths of the two input
  lists.
*)

Fixpoint min_list (l1 l2:list Z)(n:nat) : list Z :=
   match n with
      O => nil
    | S p => match l1, l2 with
                (x::rl1), (y::rl2) => if(Zle_bool x y) then 
                                        (cons x (min_list rl1 (y::rl2) p))
                                      else
                                        (cons y (min_list (x::rl1) rl2 p))
              | (x::rl1), nil => (cons x (min_list rl1 nil p))
              | nil, (y::rl2) => (cons y (min_list nil rl2 p))
              | nil, nil => nil
              end
    end.

Eval compute in min_list (3::8::1::4::nil) (1::7::3::0::nil) 5.



(* Define a function that merges two lists bu first computing the sum of their
  lengths and then calling the previous function. *)

Definition merge (l1 l2 : list Z) : list Z :=
  min_list l1 l2 (length l1 + length l2).

Eval compute in merge (3::8::1::4::nil) (1::7::3::0::nil).

(* Define a recursive function on binary trees which returns a sorted list:
  - on empty trees it returns the empty list
  - on leaf treeas carrying one value, it returns a singleton list
  - on binary nodes, it returns the merge of the two sorted lists obtained
    from the sub-components. *)

Fixpoint btToList (t:bt) : list Z :=
   match t with
      vide => nil
    | feuille val => val::nil
    | sous_ab g d => (merge (btToList g) (btToList d))
    end.

Definition arbre2 := (sous_ab (sous_ab (feuille 3) (feuille 1)) (feuille 2)).

Eval compute in btToList arbre1.
(* Define a function that sorts a list by first constructing a balanced binary
  tree and then by calling the function above. *)

Definition sortList (l:list Z) : list Z :=
   btToList (listToBt l).

Eval compute in sortList (1::7::4::2::0::9::1::nil).
