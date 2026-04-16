import PumpingLemma.Language

import Mathlib.Data.Finset.Defs
import Mathlib.Data.Set.Basic

structure DFA (α : Type) (σ : Type) where
  step : σ → α → σ
  start : σ
  accept : Set σ  -- Set σ avoids requiring DecidableEq σ

namespace DFA

variable {α : Type} {σ : Type}

-- extended transition function δ̂(q, w)
def run (M : DFA α σ) (q : σ) : List α → σ
  | []     => q
  | a :: w => M.run (M.step q a) w

def accepts (M : DFA α σ) (w : List α) : Prop :=
  M.run M.start w ∈ M.accept

def language (M : DFA α σ) : Set (List α) :=
  { w | M.accepts w }

@[simp]
theorem run_nil (M : DFA α σ) (q : σ) :
    M.run q [] = q := rfl

@[simp]
theorem run_cons (M : DFA α σ) (q : σ) (a : α) (w : List α) :
    M.run q (a :: w) = M.run (M.step q a) w := rfl

-- δ̂(q, u ++ v) = δ̂(δ̂(q, u), v)
@[simp]
theorem run_append (M : DFA α σ) (q : σ) (u v : List α) :
    M.run q (u ++ v) = M.run (M.run q u) v := by
  induction u generalizing q with
  | nil => simp
  | cons a u ih => simp [ih]

-- accepts via explicit state-sequence witness r : Fin (|w|+1) → σ
def accepts' (M : DFA α σ) (w : List α) : Prop :=
  ∃ r : Fin (w.length + 1) → σ,
    (r 0 = M.start) ∧
    (∀ i : Fin w.length, M.step (r i.castSucc) w[i] = r (i.castSucc + 1)) ∧
    (r ⟨w.length, by simp⟩ ∈ M.accept)

end DFA
