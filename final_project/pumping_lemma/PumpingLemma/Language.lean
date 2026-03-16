-- Language.lean
-- Foundational types: alphabets, words, languages, and word operations.
--
import Mathlib

abbrev Word (α : Type) := List α
abbrev Lang (α : Type) := Set (Word α)

def word_pow (w : Word α) : ℕ -> Word α
  | 0 => []
  | n + 1 => w ++ word_pow w n

instance : HPow (Word α) ℕ (Word α) where
  hPow := word_pow

theorem zero_power (w : Word α) : w ^ 0 = [] := by
  rfl

theorem succ_power (w : Word α) : w ^ (n + 1) = w ++ w ^ n := by
  rfl
