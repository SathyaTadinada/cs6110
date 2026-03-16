-- Language.lean
-- Foundational types: alphabets, words, languages, and word operations.
--
-- TODO:
--   - Define `Word α` as `List α` (or just use List α directly throughout)
--   - Define `Language α` as `Set (List α)`
--   - Define word power: `w ^ n` = w concatenated n times
--     (Lean's List doesn't have this by default; define it by recursion on n)
--   - Prove basic word power lemmas:
--       · pow_zero  : w ^ 0 = []
--       · pow_succ  : w ^ (n+1) = w ++ w ^ n
--       · pow_append: x ++ y ^ i ++ z membership rewrites

import Mathlib
