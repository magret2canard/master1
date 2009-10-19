(* Define a function that takes a tuple of natural numbers (a,b) and returns 
  the sum of the squares of both numbers. *)

Definition sum_square (a b : nat) := a * a + b * b.

Eval compute in sum_square 2 3.


(* Define a function that computes the sum of all squares between 1 and n,
  as a natural number.  Use the Fixpoint approach as described in the slides. *)



Fixpoint sum_n_square(n : nat) :=
   match n with
      0 => 0
    | S p => n*n + sum_n_square p end.

Eval compute in sum_n_square 3.


(* Write a function that maps any positive integer n to the list 1 ... n *)
(* Use the iter function shown in the slides. *)
(* Usage :
   iter n f a (for n : Z) computes f (f (f  ... a)) (n times)

   example: 

Eval compute in iter 10 Z (fun i => 2* i) 1.
   = 1024
     : Z

*)
Require Import ZArith. 
Open Scope Z_scope.

Require Import List.

Definition iota (n:Z) :=
 snd(
  iter n  (Z * (list Z)) 
	(fun p => match p with (last, l) => (last-1, last::l) end)
        (n,nil)).

Eval compute in (iota 4).

Eval compute in snd (3, (1::2::nil)).

Eval compute in iter 3 (Z * (list Z))
   (fun nl => match nl with (n, l) => (n-1, n::l) end)
   (3, nil).


(* Write a function that maps any n and any list a_1::...::a_p::nil
  to the list (n*a_1::...n*a_p::nil) *)

Fixpoint mult_list(n : Z)(l : list Z) : list Z :=
   match l with
       nil => nil
     | el::rl => let res := mult_list n rl in ((n*el)::res) end.

Eval compute in mult_list 3 (1::2::3::nil).

Definition mult_list_2 (n : Z)(l : list Z) : list Z :=
   (map
      (fun x => n*x)
      l
   ).

Eval compute in mult_list_2 3 (1::2::3::nil).


(* Hint use the map functional (slide 22) *)


(* Write a function that maps any n and any list l and returns the boolean
  value that indicates whether n is in l.
   You may use the function fold_right given in the slides and a 
   function Zeq_bool  to compare two integers *)

Fixpoint is_in_l (l : list Z)(a : Z) : bool :=
   match l with
      nil => false
    | x::rl => if(Zeq_bool x a) 
                 then true
                 else (is_in_l rl a) end.

Eval compute in is_in_l (1::2::3::nil) 1.

(* Write a function that checks whether n divides p, assuming n and p 
   are both positive.  Here's a plan:
   build the list n::2*n::...::p*n::nil,
   check whether p is in this list. *)

Definition n_div_p (n:Z)(p:Z) : bool :=
   (is_in_l
      (mult_list n (iota p))
      p
   ).

Eval compute in n_div_p 6 18.

(* Write a function that checks whether n is prime. *)

Fixpoint is_prime_anex (n:Z)(l:list Z) : bool :=
   match l with
    nil => true
  | x::rl => if(n_div_p x n)
		then false
		else (is_prime_anex n rl) end.

Definition is_prime(n:Z) : bool :=
   match (iota (n-1)) with
      p::rl => is_prime_anex n rl
     |nil => true end.

Eval compute in is_prime 1.

		          

