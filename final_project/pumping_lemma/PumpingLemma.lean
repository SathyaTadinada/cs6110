-- PumpingLemma.lean (root)
-- Top-level import. Work in the files below in this order:
--   1. PumpingLemma/Language.lean    -- Word, Language, word power
--   2. PumpingLemma/DFA.lean         -- DFA structure + run lemmas
--   3. PumpingLemma/Regular.lean     -- IsRegular definition
--   4. PumpingLemma/Pigeonhole.lean  -- state-revisit corollary
--   5. PumpingLemma/PumpingLemma.lean -- main theorem

import PumpingLemma.Language
import PumpingLemma.DFA
import PumpingLemma.Regular
import PumpingLemma.Pigeonhole
import PumpingLemma.PumpingLemma
