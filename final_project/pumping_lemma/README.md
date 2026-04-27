# Pumping Lemma in Lean

This project formalizes deterministic finite automata and proves the pumping lemma for regular languages in Lean 4.

The code develops a small automata-theory library from the ground up:

- `Language.lean` defines words and languages.
- `DFA.lean` defines deterministic finite automata, their transition semantics, and language acceptance.
- `Regular.lean` defines regular languages as those recognized by some finite DFA.
- `Pigeonhole.lean` proves the key pigeonhole argument used in the pumping lemma proof.
- `PumpingLemma.lean` contains the main theorem proving the pumping lemma for regular languages.

The top-level `PumpingLemma.lean` file imports the library modules so the project can be built as a single Lean target.

## Main Result

The central theorem is:

```lean
theorem pumping_lemma {α : Type} (L : Lang α) (hL : IsRegular L) :
		∃ p > 0, ∀ w ∈ L, p ≤ w.length →
			∃ x y z : Word α,
				w = x ++ y ++ z ∧
				y ≠ [] ∧
				(x ++ y).length ≤ p ∧
				∀ i : ℕ, x ++ y ^ i ++ z ∈ L
```

Informally, if a language is regular, then every sufficiently long word in the language can be split into `x`, `y`, and `z` so that the middle part `y` can be repeated any number of times and the resulting word stays in the language.

## Building

The project uses Mathlib and Lake. From the `pumping_lemma/` directory, build the project with:

```bash
lake build
```

You can also build the main file directly:

```bash
lake build PumpingLemma.lean
```

## Repository Layout

- `PumpingLemma/` contains the Lean development.
- `written/` contains the project report and proposal in Typst.
- `lakefile.toml` and `lake-manifest.json` configure the Lean package.
- `lean-toolchain` pins the Lean version used by the project.

## Notes

- The proof is intended to compile without `sorry`.
- The formalization follows the standard DFA-based proof of the pumping lemma, using a pigeonhole argument on visited states.
