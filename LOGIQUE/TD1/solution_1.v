(* Define a function that takes a tuple of natural numbers (a,b) and returns 
  the sum of the squares of both numbers. *)



Definition sum2 (p:nat*nat) :=
   match p with (a,b) => a*a+b*b
   end.

Eval compute in sum2 (3,4).

(* autre réponse possible *)

Definition sum2' (a b : nat) :=
  a*a+b*b.

Eval compute in sum2' 3 4.

(* Define a function that computes the sum of all squares between 1 and n,
  as a natural number.  Use the Fixpoint approach as described in the slides. *)

Fixpoint sum_squares (n:nat) : nat :=
  match n with 0 => 0
             | S p => S p * S p + sum_squares p
  end.

Eval compute in sum_squares 3.


Require Import ZArith List.
Open Scope Z_scope.


(* Write a function that maps any positive integer n to the list 1 ... n *)
(* Use the iter function shown in the slides. *)
(* Usage :
   iter n f a (for n : Z) computes f (f (f  ... a)) (n times)

   example: 

Eval compute in iter 10 Z (fun i => 2* i) 1.
   = 1024
     : Z

*)





Definition iota (n:Z) :=
 snd(
  iter n  (Z * (list Z)) 
	(fun p => match p with (last, l) => (last-1, last::l) end)
        (n,nil)).

Eval compute in (iota 4).


(* Write a function that maps any n and any list a_1::...::a_p::nil
  to the list (n*a_1::...n*a_p::nil) *)

Definition mult_by n := map (fun i => n * i).

(* exemples *)


Definition multiples (n p: Z) := mult_by n (iota p).

Eval compute in multiples 10 5.


(* Write a function that maps any n and any list l and returns the boolean
  value that indicates whether n is in l.
  Use the function fold_right given in the slides and a function Zeq_bool
  to compare two integers *)

Definition belongs n l :=
  fold_right (fun i (b:bool) => if b then true else Zeq_bool n i) false l.

Fixpoint belongs' (n:Z)(l : list Z) :=
  match l with nil => false
             | a::l' => if Zeq_bool n a then true else belongs' n l' 
  end.    







Check belongs.

Eval compute in belongs 5 (1::2::3::5::7::nil).

Eval compute in belongs 5 (1::2::3::50::7::nil).



(* Write a function that checks whether n divides p, assuming n and p 
   are both positive.  Here's a plan:
   build the list n::2*n::...::p*n::nil,
   check whether p is in this list. *)

Definition divides n p := belongs p (multiples n p).

Eval compute in divides 3 15.

(* note : en utilisant les fonctions de la bibliotheque : *)

 Definition divides2 (x p : Z) :=
  Zeq_bool (Zmod p x) 0.

Eval compute in divides2 3 15.


Definition prime (p:Z) :=
  fold_right (fun x (b:bool) => if b then 
                               negb (divides x p)
                              else false)
             true
             (map (fun i => i+1) (iota (p-2))).

(* il existe bien sûr des programmes plus efficaces mais plus complexes *)



Eval compute in prime 37.
Eval compute in prime 39.


Definition iota' (n:Z) :=
  rev (iter n _ (fun l => match l with a::tl => (a+1)::l | nil => 1::nil end)
            nil).


Definition prime2 (p : Z) :=
  match p with
    Zneg _ => false
  | 0 => false
  | Zpos p =>
    fold_right (fun x b => if divides2 x (Zpos p) then false else b) true
           (2::map (fun x => 2 * x + 1) (iota' (Zdiv (Zsqrt_plain (Zpos p)) 2)))
  end.


 Eval lazy beta zeta iota delta in prime2 1951.

 Eval compute in prime2 1951.


