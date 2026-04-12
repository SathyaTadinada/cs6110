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

/-- If M loops at state q on word y, then it loops on y^n for any n. -/
private theorem run_pow_of_loop {α σ : Type} (M : DFA α σ) (q : σ) (y : Word α)
    (hloop : M.run q y = q) : ∀ n : ℕ, M.run q (y ^ n) = q := by
  intro n
  induction n with
  | zero =>
    simp [zero_power]
  | succ k ih =>
    rw [succ_power]
    rw [DFA.run_append]
    rw [hloop]
    exact ih

theorem pumping_lemma {α : Type} (L : Set (List α)) (hL : IsRegular L) :
    ∃ p > 0, ∀ w ∈ L, p ≤ w.length →
      ∃ x y z : List α,
        w = x ++ y ++ z ∧
        y ≠ [] ∧
        (x ++ y).length ≤ p ∧
        ∀ i : ℕ, x ++ y ^ i ++ z ∈ L := by
  obtain ⟨σ, _, M, hM⟩ := hL
  refine ⟨Fintype.card σ, Fintype.card_pos_iff.mpr ⟨M.start⟩, ?_⟩
  intro w hwL hpw
  -- w ∈ L means M accepts w
  have hacc : M.run M.start w ∈ M.accept := by
    have : w ∈ M.language := hM ▸ hwL
    exact this
  -- Apply pigeonhole to get indices i < j with repeated state
  obtain ⟨⟨i, hi⟩, ⟨j, hj⟩, hij, hjp, hstates⟩ := DFA.stateAt_pigeonhole M w hpw
  -- Extract plain ℕ inequalities (Fin.val coercions confuse omega)
  have hij : i < j := hij
  have hjp : j ≤ Fintype.card σ := hjp
  -- Define the decomposition w = x ++ y ++ z
  let x := w.take i
  let y := (w.drop i).take (j - i)
  let z := w.drop j
  -- The state after reading x
  let q := M.run M.start x
  -- Prove w = x ++ y ++ z
  have hwxyz : w = x ++ y ++ z := by
    simp only [x, y, z]
    symm; rw [List.append_assoc]
    have hdrop : w.drop j = (w.drop i).drop (j - i) := by
      rw [List.drop_drop]; congr 1; omega
    rw [hdrop, List.take_append_drop, List.take_append_drop]
  -- Lengths of x and y
  have hxlen : x.length = i := by
    simp only [x, List.length_take]
    exact Nat.min_eq_left (by omega)
  have hylen : y.length = j - i := by
    simp only [y, List.length_take, List.length_drop]
    exact Nat.min_eq_left (by omega)
  have hxylen : (x ++ y).length = j := by
    simp only [List.length_append, hxlen, hylen]; omega
  -- w.take j = x ++ y
  have htakej : w.take j = x ++ y := by
    conv_lhs => rw [hwxyz, ← hxylen]
    exact List.take_left
  -- The loop: M.run q y = q
  have hloop : M.run q y = q := by
    have h1 : M.stateAt w ⟨i, hi⟩ = q := rfl
    have h2 : M.stateAt w ⟨j, hj⟩ = M.run q y := by
      change M.run M.start (w.take j) = M.run q y
      rw [htakej, DFA.run_append]
    rw [← h2, ← hstates, h1]
  -- M.run q z is accepting
  have hqz_acc : M.run q z ∈ M.accept := by
    have heq : M.run M.start w = M.run q z := by
      conv_lhs => rw [hwxyz]
      rw [DFA.run_append, DFA.run_append]
      change M.run (M.run q y) z = M.run q z
      rw [hloop]
    rw [← heq]; exact hacc
  -- y ≠ []
  have hyne : y ≠ [] := by
    intro h; simp [h] at hylen; omega
  -- (x ++ y).length ≤ p
  have hxyp : (x ++ y).length ≤ Fintype.card σ := hxylen ▸ hjp
  -- Pumping: x ++ y^n ++ z ∈ L for all n
  have hpump : ∀ n : ℕ, x ++ y ^ n ++ z ∈ L := by
    intro n
    rw [← hM]
    change M.run M.start (x ++ y ^ n ++ z) ∈ M.accept
    rw [DFA.run_append, DFA.run_append]
    change M.run (M.run q (y ^ n)) z ∈ M.accept
    rw [run_pow_of_loop M q y hloop n]
    exact hqz_acc
  exact ⟨x, y, z, hwxyz, hyne, hxyp, hpump⟩
