(* Define a function that takes a tuple of natural numbers (a,b) and returns 
  the sum of the squares of both numbers. *)



(* Define a function that computes the sum of all squares between 1 and n,
  as a natural number.  Use the Fixpoint approach as described in the slides. *)

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

Definition iterative_fact (n:Z) := 
  iter  n (Z*Z) (fun p => match p with 
                               (i,f)=>(i+1,f*(i+1))
                          end) (0,1).

Eval compute in iterative_fact 7.



(* Write a function that maps any n and any list a_1::...::a_p::nil
  to the list (n*a_1::...n*a_p::nil) *)

(* Hint use the map functional (slide 22) *)


(* Write a function that maps any n and any list l and returns the boolean
  value that indicates whether n is in l.
   You may use the function fold_right given in the slides and a 
   function Zeq_bool  to compare two integers *)

(* Write a function that checks whether n divides p, assuming n and p 
   are both positive.  Here's a plan:
   build the list n::2*n::...::p*n::nil,
   check whether p is in this list. *)

(* Write a function that checks whether n is prime. *)

