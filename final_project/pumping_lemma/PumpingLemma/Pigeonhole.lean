-- Pigeonhole.lean
-- DFA-specific pigeonhole corollary: long runs must revisit a state.
--
-- Instead of List.scanl (which lives in Batteries), we represent the
-- visited-state sequence as a plain function
--
--   stateAt M w : Fin (w.length + 1) → σ
--   stateAt M w ⟨i, _⟩  :=  M.run M.start (w.take i)
--
-- This makes the key "get" property *definitional*, eliminating the
-- List.length_scanl and scanl_get_eq_run lemmas that previously
-- required Mathlib/Batteries.  The file now imports only PumpingLemma.DFA
-- (and hence core Lean 4).

import PumpingLemma.DFA

namespace DFA

variable {α : Type} {σ : Type}

------------------------------------------------------------------------
-- Task A: stateAt definition and indexing lemma
------------------------------------------------------------------------

/-- The state reached after reading the first `i` symbols of `w` from
    `M.start`.  Defined as `M.run M.start (w.take i)`, so:

      stateAt M w ⟨0, _⟩         = M.start
      stateAt M w ⟨i, _⟩         = M.run M.start (w.take i)
      stateAt M w ⟨w.length, _⟩  = M.run M.start w

    Using a `Fin`-indexed function instead of `List.scanl` avoids any
    dependency on Batteries and makes the indexing theorem a `rfl`. -/
def stateAt (M : DFA α σ) (w : Word α) (i : Fin (w.length + 1)) : σ :=
  M.run M.start (w.take i.val)

/-- `stateAt` is definitionally the run on the prefix — no proof needed. -/
theorem stateAt_eq_run (M : DFA α σ) (w : Word α) (i : Fin (w.length + 1)) :
    M.stateAt w i = M.run M.start (w.take i.val) :=
  rfl

/-- The state at position 0 is `M.start` (the empty prefix leaves the
    state unchanged). -/
@[simp]
theorem stateAt_zero (M : DFA α σ) (w : Word α) (h : 0 < w.length + 1) :
    M.stateAt w ⟨0, h⟩ = M.start := by
  simp [stateAt]

/-- The state at the last position equals the final state of the run,
    because `w.take w.length = w`. -/
@[simp]
theorem stateAt_last (M : DFA α σ) (w : Word α) :
    M.stateAt w ⟨w.length, Nat.lt_succ_self _⟩ = M.run M.start w := by
  simp [stateAt, List.take_length]

end DFA
