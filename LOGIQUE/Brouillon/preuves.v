Check True.

Check False.

Check true.

Section Propositional_Logic. 
Variables P Q R T : Prop.

Check P.

Check ((P ->(Q /\ P)) -> (Q -> P)).

Section Minimal_propositioal_logic.

 Lemma imp_dist : (P -> (Q -> R)) -> (P -> Q) -> P -> R.
 Proof.
  intro H.
  intro H0.
  intro H1.
  apply H.
  assumption.
  apply H0.
  assumption.
 Qed.