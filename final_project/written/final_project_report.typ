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

= Demo
Give a worked example of your project code in action. Use pictures or codeblocks. Describe a motivating instance, explain what should happen, and show what your code achieves.

= Implementation
Explain how the code works to support the demo in particular and in general.


= Future Work
List next steps for the project.
- If you completed all your goals, this can be a quick 1-2 sentence section. E.g., "I'm done"; "Next step is to write a paper"
- If not, outline how you would approach each next step. Which tasks seem straightforward, and which are less clear? Does your current code need fundamental changes?

= Discussion
Pretend that you will take a 1 year break, then come back to this project. Write notes that would be useful for your future self.
- Example questions to answer: What did you learn from the project? What challenges did you face? How did you overcome or avoid the challenges? What would you do differently if you could start over?
- You can discuss some of these questions or write your own reflections.
