#import "@preview/charged-ieee:0.1.4": ieee

#show: ieee.with(
  title: [Modeling Finite-State Automata in Lean],
  abstract: [
    #lorem(100)
  ],
  authors: (
    (
      name: "Henry Zheng",
      // department: [Co-Founder],
      // organization: [Typst GmbH],
      // location: [Berlin, Germany],
      email: "u1340759@utah.edu"
    ),
    (
      name: "Sathya Tadinada",
      // department: [Co-Founder],
      // organization: [Typst GmbH],
      // location: [Berlin, Germany],
      email: "sathya.tadinada@utah.edu"
    ),
  ),
  index-terms: ("Finite-State Automata", "Pumping Lemma", "Formal Verification", "Lean"),
  // bibliography: bibliography("refs.bib"),
)

= Introduction
Describe the problem, explain why it is important, and outline your approach to solving the problem. Cite related work where applicable. List the ideal contributions you would hope to achieve, regardless of where your project ended up.
- Aim for an introduction that could appear at a top-tier conference in your area. A reviewer who reads this intro should be excited to see (and accept!) the rest of the paper.
- Use the contributions as a wishlist for where you'd hope to end up with a few more weeks of successful research.
- Simon Peyton Jones recommends writing a wishlist intro before starting any research project

= Status
Explain the current project status relative to the ideal contributions. What works? What's next? Keep it brief. The purpose of this section is to set expectations for the rest of the document (for me at least, but perhaps for your advisor too!).

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
