-- Regular.lean
-- Definition of regular languages via DFA recognition.
--
-- TODO:
--   - Define `IsRegular (L : Set (List α)) : Prop`:
--       ∃ (σ : Type) (_ : Fintype σ) (M : DFA α σ), M.language = L
--     Note: [Fintype σ] is essential — it gives us a finite state count for
--     the pumping length p = Fintype.card σ.
--   - Optionally prove closure properties if needed (union, concatenation, star),
--     though they are not required for the pumping lemma itself.

import Mathlib
import PumpingLemma.DFA
