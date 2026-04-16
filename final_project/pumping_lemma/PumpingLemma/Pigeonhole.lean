import PumpingLemma.DFA

import Mathlib.Data.Fintype.Card

namespace DFA

variable {α : Type} {σ : Type}

-- state reached after reading the first i symbols of w from M.start
def stateAt (M : DFA α σ) (w : Word α) (i : Fin (w.length + 1)) : σ :=
  M.run M.start (w.take i.val)

theorem stateAt_eq_run (M : DFA α σ) (w : Word α) (i : Fin (w.length + 1)) :
    M.stateAt w i = M.run M.start (w.take i.val) :=
  rfl

@[simp]
theorem stateAt_zero (M : DFA α σ) (w : Word α) (h : 0 < w.length + 1) :
    M.stateAt w ⟨0, h⟩ = M.start := by
  simp [stateAt]

@[simp]
theorem stateAt_last (M : DFA α σ) (w : Word α) :
    M.stateAt w ⟨w.length, Nat.lt_succ_self _⟩ = M.run M.start w := by
  simp [stateAt, List.take_length]

-- if w.length >= card σ, some state is visited twice
theorem stateAt_pigeonhole [Fintype σ] (M : DFA α σ) (w : Word α)
    (hw : Fintype.card σ ≤ w.length) :
    ∃ (i j : Fin (w.length + 1)),
      i.val < j.val ∧
      j.val ≤ Fintype.card σ ∧
      M.stateAt w i = M.stateAt w j := by
  have hlt : ∀ k : Fin (Fintype.card σ + 1), k.val < w.length + 1 :=
    fun k => by have := k.isLt; omega
  let f : Fin (Fintype.card σ + 1) → σ := fun k => M.stateAt w ⟨k.val, hlt k⟩
  have hcard : (Finset.univ : Finset σ).card <
      (Finset.univ : Finset (Fin (Fintype.card σ + 1))).card := by simp
  obtain ⟨a, -, b, -, hab, hfab⟩ :=
    Finset.exists_ne_map_eq_of_card_lt_of_maps_to hcard (f := f)
      (fun _ _ => Finset.mem_univ _)
  rcases Nat.lt_or_gt_of_ne (Fin.val_ne_of_ne hab) with h | h
  · exact ⟨⟨a.val, hlt a⟩, ⟨b.val, hlt b⟩, h, Nat.lt_succ_iff.mp b.isLt, hfab⟩
  · exact ⟨⟨b.val, hlt b⟩, ⟨a.val, hlt a⟩, h, Nat.lt_succ_iff.mp a.isLt, hfab.symm⟩

end DFA
