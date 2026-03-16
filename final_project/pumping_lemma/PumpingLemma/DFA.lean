-- DFA.lean
-- Deterministic finite automaton: structure, run semantics, and helper lemmas.
--
-- TODO:
--   - Define the DFA structure:
--       structure DFA (α : Type) (σ : Type) where
--         start  : σ
--         accept : Finset σ
--         step   : σ → α → σ
--   - Define `DFA.run (M : DFA α σ) : σ → List α → σ` by recursion on the word
--   - Define `DFA.accepts (M : DFA α σ) (w : List α) : Prop`
--       := M.run M.start w ∈ M.accept
--   - Define `DFA.language (M : DFA α σ) : Set (List α)`
--       := {w | M.accepts w}
--   - Prove key run lemmas (the pumping proof depends heavily on these):
--       · run_nil   : M.run q [] = q
--       · run_cons  : M.run q (a :: w) = M.run (M.step q a) w
--       · run_append: M.run q (u ++ v) = M.run (M.run q u) v
--         (prove by induction on u; this is the critical lemma)

import Mathlib
import PumpingLemma.Language

import Mathlib.Data.Set.Basic

universe u v
variable {Q : Type u} {σ : Type v}

-- yoinked from https://nelsmartin.github.io/ComputationBook/
structure DFA (Q : Type u) (Σ : Type v) where
  δ : Q → σ → Q  -- delta (transition) function
  q₀ : Q         -- start state
  F : Set Q      -- accept states

namespace DFA
