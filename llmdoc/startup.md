# Startup Reading Order

## Must Read Every Session
1. `llmdoc/must/project-essentials.md` — project identity, XeLaTeX-only support, source model, keyed APIs, build/test commands, dependencies, and current watchpoints.

## Then Escalate Based on Task Type
- If the task is about project purpose, release state, repository-shape changes, or modernization framing, read `llmdoc/overview/project-overview.md`.
- If the task is about class behavior, key namespaces, compatibility shims, front matter, page layout, or expl3 internals, read `llmdoc/architecture/class-architecture.md`.
- If the task is about `\sdusetup`, `l3build`, CI, documentation-driver choices, or repository-level modernization facts, read `llmdoc/reference/modernization-reference.md`.
- If the task touches unclear or undocumented areas, also read `llmdoc/memory/doc-gaps.md` before changing stable docs.

## Escalation Heuristics
- Build or test issue: start with project essentials, then modernization reference.
- Behavior bug in generated class output: read project essentials, then class architecture.
- Cover, statement, abstract, or front-matter task: read class architecture and modernization reference.
- Planning a change to options, metadata, or compatibility behavior: read class architecture, modernization reference, and doc gaps.
- Updating llmdoc itself: read all current llmdoc files in the touched categories and check `llmdoc/memory/doc-gaps.md` for unresolved boundaries.
