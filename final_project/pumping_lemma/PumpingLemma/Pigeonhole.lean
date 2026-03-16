-- Pigeonhole.lean
-- DFA-specific pigeonhole corollary: long runs must revisit a state.
--
-- Mathlib already provides:
--   Finset.exists_ne_map_eq_of_card_lt_of_maps_to
--     (if |s| < |t| and f maps s into t, then f is not injective on s)
--
-- TODO:
--   - Define `DFA.statesVisited (M : DFA α σ) (w : List α) : List σ`
--       = the sequence of states visited during M.run M.start w
--       (length = w.length + 1, including the start state)
--   - Prove the key pigeonhole corollary:
--       If Fintype.card σ ≤ w.length, then statesVisited has a repeated state:
--         ∃ i j, i < j ∧ j ≤ w.length ∧ statesVisited[i] = statesVisited[j]
--       Use Finset.exists_ne_map_eq_of_card_lt_of_maps_to (or List.Nodup) on
--       the prefix of statesVisited of length (card σ + 1).
--   - The indices i and j give you the split w = x ++ y ++ z where:
--       x = w.take i
--       y = w.take j |>.drop i   (nonempty since i < j)
--       z = w.drop j

import Mathlib
import PumpingLemma.DFA
