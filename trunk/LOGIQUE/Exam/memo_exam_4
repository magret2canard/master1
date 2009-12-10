(* On definit le predicat suivant *)

Definition multiple_de_3 (n : nat) := exists p:nat, n = 3 * p.



(* On admet le resultat suivant (demonstration non demandée) : *)

Lemma mult3_inv : forall n, multiple_de_3 n ->
                            n = 0 \/ 
                            exists p, n = 3 + p /\ multiple_de_3 p.
Admitted.



(* Note : on rappelle que "discriminate H" permet de resoudre tout
but contenant une hypothese H : n = p, ou n et p seont deux entiers
differents.

Par exemple :

Goal  forall n, 2 <> 4+ n.
intros n H;discriminate H.
Qed.
*)

(* Prouver le lemme ci-dessous (on utilisera mult3_inv) *)



Lemma One_not_mult3 : ~multiple_de_3 1.
  Proof.

(*
1 subgoal
______________________________________(1/1)
~ multiple_de_3 1
*)

  intro H.

(*
1 subgoal
H : multiple_de_3 1
______________________________________(1/1)
False
*)

  destruct (mult3_inv 1 H).

(*
2 subgoals
H : multiple_de_3 1
H0 : 1 = 0
______________________________________(1/2)
False


______________________________________(2/2)
False
*)

  discriminate H0.

(*
1 subgoal
H : multiple_de_3 1
H0 : exists p : nat, 1 = 3 + p /\ multiple_de_3 p
______________________________________(1/1)
False
*)

  destruct H0 as [p Hp].

(*
1 subgoal
H : multiple_de_3 1
p : nat
Hp : 1 = 3 + p /\ multiple_de_3 p
______________________________________(1/1)
False
*)

  destruct Hp as [H1 H2].

(*
1 subgoal
H : multiple_de_3 1
p : nat
H1 : 1 = 3 + p
H2 : multiple_de_3 p
______________________________________(1/1)
False
*)

  discriminate H1.
  Qed.




