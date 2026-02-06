= Modeling a Ring Election
== Your Task
Fill in the blanks to model a ring election for a network of servers.
- Starter code: `election.frg`
- Background:
  - Servers are arranged in a ring. Each server has one `successor`.
  - Each server has an integer `ID`.
  - During the election, each server sends its `ID` across the ring to every other server.
  - The server with the highest `ID` should win the election.
- Goal: all tests should pass when you run the file and all the "TODO" blanks should be filled in.

#image("ring.png")

== Setup
Instructions: https://forge-fm.github.io/forge-documentation/5.0/getting-started/installation/

== Learning Goals
- Encode informal specifications with logic and sets.
- Model a system that evolves over time.
- Understand the purposes of sigs, predicates, and instances.

== Links
Forge docs: https://forge-fm.github.io/forge-documentation/5.0/
