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

import Mathlib.Data.Fintype.Card  -- Fintype.card; Finset.exists_ne_map_eq_of_card_lt_of_maps_to

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

------------------------------------------------------------------------
-- Task B: Pigeonhole corollary for stateAt
------------------------------------------------------------------------

/-- If the word is at least as long as the number of states, some state is
    visited twice.  Returns indices i < j ≤ Fintype.card σ (both valid
    prefix indices for w) such that the DFA is in the same state at both. -/
theorem stateAt_pigeonhole [Fintype σ] (M : DFA α σ) (w : Word α)
    (hw : Fintype.card σ ≤ w.length) :
    ∃ (i j : Fin (w.length + 1)),
      i.val < j.val ∧
      j.val ≤ Fintype.card σ ∧
      M.stateAt w i = M.stateAt w j := by
  -- Every index k ≤ Fintype.card σ is a valid prefix index for w
  have hlt : ∀ k : Fin (Fintype.card σ + 1), k.val < w.length + 1 :=
    fun k => by have := k.isLt; omega
  -- Map each such prefix index to the visited state
  let f : Fin (Fintype.card σ + 1) → σ := fun k => M.stateAt w ⟨k.val, hlt k⟩
  -- There are (card σ + 1) prefix indices but only (card σ) states, so two must collide
  have hcard : (Finset.univ : Finset σ).card <
      (Finset.univ : Finset (Fin (Fintype.card σ + 1))).card := by simp
  obtain ⟨a, -, b, -, hab, hfab⟩ :=
    Finset.exists_ne_map_eq_of_card_lt_of_maps_to hcard (f := f)
      (fun _ _ => Finset.mem_univ _)
  -- Orient the two colliding indices so the smaller comes first
  rcases Nat.lt_or_gt_of_ne (Fin.val_ne_of_ne hab) with h | h
  · -- a.val < b.val: use i = a, j = b
    exact ⟨⟨a.val, hlt a⟩, ⟨b.val, hlt b⟩, h, Nat.lt_succ_iff.mp b.isLt, hfab⟩
  · -- b.val < a.val: use i = b, j = a
    exact ⟨⟨b.val, hlt b⟩, ⟨a.val, hlt a⟩, h, Nat.lt_succ_iff.mp a.isLt, hfab.symm⟩

end DFA
