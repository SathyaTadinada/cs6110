-- PumpingLemma.lean
-- Main theorem: every regular language satisfies the pumping lemma.
--
-- Target statement:
--   theorem pumping_lemma {α : Type} (L : Set (List α)) (hL : IsRegular L) :
--       ∃ p > 0, ∀ w ∈ L, p ≤ w.length →
--         ∃ x y z : List α,
--           w = x ++ y ++ z ∧
--           y ≠ [] ∧
--           (x ++ y).length ≤ p ∧
--           ∀ i : ℕ, x ++ y ^ i ++ z ∈ L
--
-- Proof outline:
--   1. From hL, extract a DFA M over finite state type σ.
--      Set p = Fintype.card σ.
--   2. Given w ∈ L with p ≤ w.length:
--      Apply the pigeonhole lemma (Pigeonhole.lean) to get indices i < j ≤ p
--      where the run of w revisits a state q.
--   3. Split w = x ++ y ++ z using List.take / List.drop at i and j.
--   4. Show y ≠ [] (since i < j) and (x++y).length ≤ p (since j ≤ p).
--   5. For any n : ℕ, show x ++ y^n ++ z ∈ L:
--      Use run_append to show M.run M.start (x ++ y^n ++ z)
--        = M.run q (y^n ++ z)          -- x brings start to q
--        = M.run q z                   -- y is a loop at q (run q y = q)
--        = M.run M.start w's final state, which is in M.accept.

import Mathlib.Data.Fintype.Card  -- Fintype.card, card_pos_iff
import PumpingLemma.Language
import PumpingLemma.DFA
import PumpingLemma.Regular
import PumpingLemma.Pigeonhole
