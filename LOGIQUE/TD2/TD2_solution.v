Require Import ZArith List.
Open Scope Z_scope.

(* Define a datatype of binary trees where non-atomic nodes have only two
  components which are binary trees, and only atomic nodes carry an integer
  value.  Include a case for empty trees. *)

Inductive bt : Type :=  E | L (x : Z) | N (t1 t2 : bt).

(* Define a function that takes a list as input and constructs a balanced
  binary tree carrying the same values.  The trick is to interchange the
  the two components of each node after inserting an integer into the first
  node -- beware that you have to define two recursive functions for this
  question. *)

Fixpoint insert_bt (x : Z) (t : bt) : bt :=
  match t with
    E => L x
  | L y => N (L x) (L y)
  | N t1 t2 =>  N t2 (insert_bt x t1)
  end.

Definition bt_of_l : list Z -> bt := fold_right insert_bt E.

(* Define a function with three arguments: a natural number and two
  lists, which builds a new list by always taking the least element
  of the heads of the two lists.  The length of the resulting list should
  be the natural number given as first input (if the two lists are long enough).

  This is a merge function as in the "merge sort" algorithm, except that the
  natural number argument should be the sum of the lengths of the two input
  lists.
*)

Fixpoint merge' (n:nat)(l1 l2 : list Z) : list Z :=
  match n with
    O => nil
  | S p => 
    match l1, l2 with
      (a::l1), (b::l2) =>
         if Zle_bool a b then
            a::merge' p l1 (b::l2)
         else
            b::merge' p (a::l1) l2
    | (a::l1), nil => a::merge' p l1 nil
    | nil, (b::l2) => b::merge' p nil l2
    | nil, nil => nil
    end
  end.

(* Define a function that merges two lists bu first computing the sum of their
  lengths and then calling the previous function. *)

Definition merge (l1 l2 : list Z) : list Z :=
  merge' (length l1 + length l2) l1 l2.

(* Define a recursive function on binary trees which returns a sorted list:
  - on empty trees it returns the empty list
  - on leaf treeas carrying one value, it returns a singleton list
  - on binary nodes, it returns the merge of the two sorted lists obtained
    from the sub-components. *)

Fixpoint sl_of_bt (t : bt) : list Z :=
  match t with
    E => nil
  | L x => x::nil
  | N t1 t2 => merge (sl_of_bt t1) (sl_of_bt t2)
  end.

(* Define a function that sorts a list by first constructing a balanced binary
  tree and then by calling the function above. *)

Definition merge_sort (l:list Z) := sl_of_bt (bt_of_l l).

(* Define a function that takes three integers a, b, and n and constructs the
  list a^n mod b, a^(n-1) mod b, ....  a mod b -- use the iter function
  as in the previous class.  Use this function to generate large lists of
  pseudo-random numbers.  Test your sorting function on these inputs. *)

Definition pseudo_rand a b n :=
  let (_, l) := iter n (Z*list Z) (fun p => 
                     let (v,l) := p in
                     let v' := Zmod (a * v) b in
                          (v', v'::l)) (1, nil) in
  l.

Definition l1 := Eval vm_compute in pseudo_rand 1789 100003 500.

Eval vm_compute in length l1.
Time Eval vm_compute in (merge_sort l1).


Fixpoint sorted_bool (l:list Z) : bool :=
 match l with nil => true
            | a::nil => true
            | a::((b::l) as l1)  => if Zle_bool a b 
                                    then sorted_bool l1 
                                    else false
 end.

Eval compute in sorted_bool (merge_sort l1).
Eval vm_compute in sorted_bool l1.


