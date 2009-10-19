Require Import List.

Definition l1 := (1::2::nil).

Eval compute in cons 3 l1.

Eval compute in cons 3 nil.

Require Import ZArith. 
Open Scope Z_scope.

Eval compute in Zeq_bool 3 3.

Eval compute in ! true.