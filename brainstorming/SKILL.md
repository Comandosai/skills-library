---
name: brainstorming
description: "You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Interrogates the user one question at a time, recommending an answer to each, and checkpoints decisions to a living doc until there are no gaps - so you start at 90% understanding, not 70%."
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs and specs through a relentless, one-question-at-a-time interview.

Walk down each branch of the design tree, resolving dependencies between decisions one by one. Start by understanding the current project context, ask questions until there are no gaps, then present the design in small sections (200-300 words), checking each as you go. Don't start building until the plan has no open questions left.

## The Process

**Understanding the idea (interview):**
- Check out the current project state first (files, docs, recent commits)
- **If a question can be answered by exploring the codebase, explore the codebase instead of asking.** Never ask the user something the repo already answers.
- Ask questions ONE at a time. Only one question per message - if a topic needs more exploration, break it into multiple questions.
- **For every question, provide your own recommended answer with a short reason.** The user should be able to just say "ok" and move on. Lead with the recommendation, not a blank prompt.
- Prefer multiple choice questions when possible, but open-ended is fine too
- Walk the decision tree: resolve dependencies between decisions one by one (a choice that unlocks or constrains later choices comes first)
- Focus on understanding: purpose, constraints, success criteria, edge cases, what's explicitly out of scope

**Exploring approaches:**
- Propose 2-3 different approaches with trade-offs
- Present options conversationally with your recommendation and reasoning
- Lead with your recommended option and explain why

**Presenting the design:**
- Once the interview has no gaps left, present the design
- Break it into sections of 200-300 words
- Ask after each section whether it looks right so far
- Cover: architecture, components, data flow, error handling, testing
- Be ready to go back and clarify if something doesn't make sense

## Checkpoint After Every Answer

After each answer, append it to a living markdown file under `brainstorms/` at the project root (create the folder if it doesn't exist), named `YYYY-MM-DD-<topic>.md`. The file holds:

- **Summary** - one line on what we're designing
- **Decisions so far** - the settled choices, newest first
- **Q&A log** - step-by-step record of question → recommendation → user's answer
- **Open flags** - things still to go find out (unanswered questions, things to verify in code, external unknowns)

Keep looping until the Open flags section is empty and the doc has no gaps. This makes the session crash-safe and resumable - if interrupted, the file is the source of truth to pick up from.

## After the Design

**Documentation:**
- Promote the validated design to `docs/plans/YYYY-MM-DD-<topic>-design.md`
- Use elements-of-style:writing-clearly-and-concisely skill if available
- Commit the design document to git
- Offer to update any related skills or docs with what was learned during the interview

**Implementation (if continuing):**
- Ask: "Ready to set up for implementation?"
- Use superpowers:using-git-worktrees to create isolated workspace
- Use superpowers:writing-plans to create detailed implementation plan

## Key Principles

- **One question at a time** - Don't overwhelm with multiple questions
- **Recommend an answer to every question** - the user defaults to "ok"; you do the thinking
- **Explore code before asking** - if the repo answers it, don't ask the user
- **Multiple choice preferred** - Easier to answer than open-ended when possible
- **Walk the decision tree** - resolve dependencies between decisions one by one
- **Checkpoint every answer** - keep a living `brainstorms/` doc so the session is resumable
- **Loop until no gaps** - finish only when there are no open flags left
- **YAGNI ruthlessly** - Remove unnecessary features from all designs
- **Explore alternatives** - Always propose 2-3 approaches before settling
- **Incremental validation** - Present design in sections, validate each
- **Be flexible** - Go back and clarify when something doesn't make sense

---

*Interview discipline (one question at a time, recommended answer per question, living checkpoint, loop-until-no-gaps) adapted from Matt Pocock's "grill-me" skill.*
