import Mathlib.Data.Fintype.Basic
import PumpingLemma.DFA

-- L is regular if recognized by some DFA with finite state space
def IsRegular {α : Type} (L : Set (List α)) : Prop :=
  ∃ (σ : Type) (_ : Fintype σ) (M : DFA α σ), M.language = L
