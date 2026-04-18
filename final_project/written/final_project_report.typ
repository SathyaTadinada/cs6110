#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [Modeling Finite-State Automata in Lean],
  abstract: [
    Our goal is to model finite-state machines (FSMs) in the Lean proof assistant. FSMs are a fundamental concept in theoretical computer science, used to recognize regular languages and model computational processes. They have applications in various fields, including compiler design, natural language processing, and formal verification. We primarily focus on proving the pumping lemma as a proof-of-concept for our FSM model, which is a crucial tool for proving that certain languages are not regular. We also discuss the challenges we faced in modeling FSMs in Lean and how we overcame them.
  ],
  authors: (
    (
      name: "Henry Zheng",
      organization: [University of Utah],
      location: [Salt Lake City, Utah],
      email: "u1340759@utah.edu",
    ),
    (
      name: "Sathya Tadinada",
      organization: [University of Utah],
      location: [Salt Lake City, Utah],
      email: "sathya.tadinada@utah.edu",
    ),
  ),
  index-terms: ("Finite-State Automata", "Pumping Lemma", "Formal Verification", "Lean"),
  bibliography: bibliography("final_project_report.bib"),
)

#set text(
  size: 11pt
)

// Describe the problem, explain why it is important, and outline your approach
// to solving the problem. Cite related work where applicable. List the ideal
// contributions you would hope to achieve, regardless of where your project
// ended up.
// - Aim for an introduction that could appear at a top-tier conference in your
//   area. A reviewer who reads this intro should be excited to see (and
//   accept!) the rest of the paper.
// - Use the contributions as a wishlist for where you'd hope to end up with a
//   few more weeks of successful research.
// - Simon Peyton Jones recommends writing a wishlist intro before starting any
//   research project
= Introduction
Our general problem is to model finite-state machines (FSMs) in the Lean proof
assistant. FSMs are a fundamental concept in theoretical computer science, used
to recognize regular languages and model computational processes. They have
applications in various fields, including compiler design, natural language
processing, and formal verification. Modeling FSMs in Lean allows us to
formally verify properties of these automata, such as language recognition and
the pumping lemma, which is a crucial tool for proving that certain languages
are not regular.

Specifically, we aim to define a formal representation of deterministic finite
automata (DFA) in Lean, along with operations such as state transitions and
language recognition. We also plan to implement the pumping lemma for regular
languages, which will enable us to prove that certain languages cannot be
recognized by any DFA.

To briefly recap the problem statement, we'll summarize Michael Sipser's
"Introduction to the Theory of Computation" and the relevant sections on finite
automata and the pumping lemma @sipser97. A DFA is defined as a 5-tuple $(Q,
Sigma, delta, q_0, F)$, where
1. $Q$ is a finite set of states,
2. $Sigma$ is a finite input alphabet,
3. $delta: Q times Sigma -> Q$ is the transition function, which maps a state
   and an input symbol to a next state,
4. $q_0 in Q$ is the start state, and
5. $F subset Q$ is the set of accepting states.

Computation proceeds by "running" a string on a DFA and checking if it is
accepted. We say that a DFA $M = (Q, Sigma, delta, q_0, F)$ _accepts_ a string
if
1. $r_0 = q_0$,
2. $delta(r_i, w_(i+1)) = r_(i+1)$ for $0 <= i < n$, and
3. $r_n in F$.

A language is a set of strings over an alphabet. A language is _regular_ if
there exists a DFA that accepts exactly the strings in that language. The
pumping lemma provides a necessary condition for a language to be regular,
which can be used to show that certain languages are not regular by
demonstrating that they do not satisfy the conditions of the lemma.

The pumping lemma states that for any regular language $L$, there exists a
pumping length $p$ such that any string $s$ in $L$ with length at least $p$ can
be decomposed into three parts, $s = x y z$, satisfying the following
conditions:
1. For each $i >= 0$, the string $x y^i z$ is in $L$,
2. $|y| > 0$, and
3. $|x y| <= p$.

We will follow the traditional proof for the pumping lemma. By the pigeonhole
principle, for a DFA with $n$ states, any string with over $n$ characters must
revisit a state. If the state is visited twice, then we may remove the "loop"
which causes it to be revisited, or re-run the "loop" repeatedly. This is the
intuition behind the pumping lemma, and we will formalize this proof in Lean.
The proof should be mostly straightforward, but we will need to be careful with
the details of the decomposition of the string and the conditions on the
lengths of the parts.

Our primary goal is to successfully model DFAs in Lean and prove the pumping
lemma for regular languages. This will demonstrate that our model of FSMs is
robust enough to capture important properties of regular languages.
Additionally, we hope to explore further properties of regular languages and
potentially extend our model to include non-deterministic finite automata
(NFAs) and their equivalence to DFAs.

// Explain the current project status relative to the ideal contributions. What
// works? What's next? Keep it brief. The purpose of this section is to set
// expectations for the rest of the document (for me at least, but perhaps for
// your advisor too!).
= Status
We have successfully defined a formal representation of deterministic finite
automata (DFA) in Lean, including the necessary components such as states,
input alphabet, transition function, start state, and accepting states. We have
also implemented the language recognition function for our DFA model, allowing
us to determine whether a given string is accepted by a DFA. Additionally, we
have completed the proof of the pumping lemma for regular languages using our
DFA model in Lean. This demonstrates that our model is robust enough to capture
important properties of regular languages and allows us to formally verify the
pumping lemma.

The primary deliverable of our project is the formal proof of the pumping
lemma, which is a crucial tool for proving that certain languages are not
regular. The statement of the pumping lemma in our Lean code is as follows:
```lean
theorem pumping_lemma {α : Type} (L : Lang α) (hL : IsRegular L) :
    ∃ p > 0, ∀ w ∈ L, p ≤ w.length →
      ∃ x y z : Word α,
        w = x ++ y ++ z ∧
        y ≠ [] ∧
        (x ++ y).length ≤ p ∧
        ∀ i : ℕ, x ++ y ^ i ++ z ∈ L
```

We did not extend our model to include non-deterministic finite automata (NFAs)
or explore further properties of regular languages, as our primary focus was on
modeling DFAs and proving the pumping lemma. However, we have laid a solid
foundation for future work in these areas, and we hope to explore them in
future steps of our project.

// Give a worked example of your project code in action. Use pictures or
// codeblocks. Describe a motivating instance, explain what should happen, and
// show what your code achieves.
= Demo
The demonstration of our project is relatively straightforward, as we have
successfully implemented the pumping lemma for regular languages in Lean. Our
proof can be known to be correct by construction simply by building the Lean
project and verifying that it compiles without errors. Below is a brief
walkthrough of how to run the demo and verify the proof.

Our project is hosted on GitHub under `SathyaTadinada/cs6110`. Clone the
project, `cd` into the project directory (`final_project/pumping_lemma`), and
run `lake build PumpingLemma.lean` to build the project and verify that the
proof of the pumping lemma compiles successfully. If the build process
completes without any errors, it indicates that our proof is correct and that
our model of DFAs in Lean is robust enough to capture the necessary properties
of regular languages. Below is a screenshot of the terminal output after
successfully building the project:
#image("lake_build.png")

Furthermore, we do not rely on `sorry` within our proof. This can be easily
verified by grepping for `sorry` in our codebase and confirming that it does
not appear. This means that our proof is complete and does not contain any
unproven assumptions or placeholders.

// Explain how the code works to support the demo in particular and in general.
= Implementation
Our work in this project was split across five files: `Language.lean`,
`DFA.lean`, `Regular.lean`, `Pigeonhole.lean`, and `PumpingLemma.lean`. The
first three files define the necessary components of our model of finite-state
automata (FSMs) in Lean, while the last two files contain the proof of the
pumping lemma for regular languages.

In `Language.lean`, we define the concept of a language as a set of strings
over an alphabet. We also define the notion of a word, which is a list of
symbols from the alphabet, and provide basic operations for working with
languages and words. Under the hood, we represent languages as sets of words,
and words as lists parameterized by the type of symbols in the alphabet. This
was a sticking point when starting the project, as traditional mathematics
define everything in terms of sets, but in Lean, it is more natural to work
with types and functions. Many of the places where we would have used a set
were instead replaced by being described by a type. We had to carefully design
our definitions to ensure that they were both mathematically sound and
compatible with Lean's type system.

Our `DFA.lean` file defines the structure of a deterministic finite automaton
(DFA) in Lean. We define a DFA as a structure that includes a transition
function, a start state, and a set of accepting states. Instead of coding the
input alphabet and set of states within the DFA structure, we parameterize the
DFA over two types, which are represent the above. This follows previous
(unfinished) work on modeling DFAs @martin25, and is idiomatic Lean style. We
also implement the language recognition function for our DFA model, which takes
a string as input and determines whether it is accepted by the DFA.

Our `Regular.lean` file defines the concept of regular languages and provides a
way to determine whether a given language is regular by checking if there
exists a DFA that recognizes it.

Our `Pigeonhole.lean` file contains the proof of the pigeonhole principle,
which is a key component of the proof of the pumping lemma. The pigeonhole
principle states that if you have $n$ containers and more than $n$ items to
place in those containers, then at least one container must contain more than
one item. This principle is used in the proof of the pumping lemma to show that
if a string is long enough, it must revisit a state in the DFA, which allows us
to decompose the string into parts that can be "pumped". Proving this
constructively was admittedly more difficult than the traditional method (proof
by contradiction). We had to yield two indices $i <= j$ such that the DFA would
be in the same state at index $i$ and $j$. We ended up using a proof of the
pigeonhole principle for finite sets from `Mathlib` to yield these indices,
which was a bit of a black box. However, we verified that the conditions for
using this lemma were satisfied in our proof, and it allowed us to complete the
proof of the pumping lemma in a constructive manner.

Finally, our `PumpingLemma.lean` file contains the formal proof of the pumping
lemma for regular languages using our model of DFAs in Lean. The proof follows
the traditional approach, using the pigeonhole principle to show that any
sufficiently long string accepted by a DFA can be decomposed into parts that
satisfy the conditions of the pumping lemma. We use the aforementioned $i$ and
$j$ indices as the endpoints of the `y` part of the string, which is the part
that can be "pumped". We then verify that the `y` part may be "pumped" (i.e.,
repeated any number of times) while still being accepted by the DFA, which
completes the proof of the pumping lemma.

// List next steps for the project.
// - If you completed all your goals, this can be a quick 1-2 sentence section.
//   E.g., "I'm done"; "Next step is to write a paper"
// - If not, outline how you would approach each next step. Which tasks seem
//   straightforward, and which are less clear? Does your current code need
//   fundamental changes?
= Future Work
Our primary goal of modeling finite-state automata (FSMs) in Lean and proving
the pumping lemma for regular languages has been successfully achieved.
However, there are several potential next steps for our project that we could
explore in the future. One natural extension would be to model
non-deterministic finite automata (NFAs) in Lean and prove their equivalence to
DFAs. This would involve defining a formal representation of NFAs, including
their transition function, which allows for multiple possible next states for a
given input symbol. We would then need to implement the subset construction
algorithm to convert an NFA into an equivalent DFA and prove that the languages
recognized by both automata are the same. This would further demonstrate the
robustness of our FSM model in Lean and allow us to explore more complex
properties of regular languages.

Additionally, we could explore other properties of regular languages. There are
many useful closure properties on regular languages, such as closure under
union, intersection, and complementation. We could formalize and prove these
properties in Lean using our DFA model. This would involve defining the
operations for combining DFAs to recognize the union or intersection of
languages and proving that the resulting automata correctly recognize the
intended languages. Proving closure under complementation would involve
constructing a DFA that recognizes the complement of a given regular language
and verifying its correctness.

Another goal would be to formalize and prove other important theorems in
automata theory. It would be useful to work with automata that don't model
regular languages (such as push-down automata for context-free languages or
Turing machines for recognizable languages) and explore their properties and
relationships to regular languages. For example, we could investigate the
pumping lemma for context-free languages. This would involve defining push-down
automata in Lean and proving the necessary conditions for a language to be
context-free. It would also be useful to prove that the expressiveness of the
language hierarchy is strictly increasing; i.e., regular languages can be
modeled by context-free languages, which can be modeled by recognizable
languages, but not vice versa. This would involve proving that there are
languages that can be recognized by push-down automata but not by finite
automata, and that there are languages that can be recognized by Turing
machines but not by push-down automata.

Overall, while we have achieved our primary goals, there are many directions
for future work that could further enhance our understanding of automata theory
and the capabilities of our FSM model in Lean.

= Discussion
Pretend that you will take a 1 year break, then come back to this project. Write notes that would be useful for your future self.
- Example questions to answer: What did you learn from the project? What challenges did you face? How did you overcome or avoid the challenges? What would you do differently if you could start over?
- You can discuss some of these questions or write your own reflections.
