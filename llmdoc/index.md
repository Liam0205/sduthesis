# llmdoc Index

## Purpose
This index is the global map of stable project documentation. Use it to find the right document by concept or task area. For startup reading order, use `llmdoc/startup.md` instead.

## must
- `llmdoc/must/project-essentials.md` — dense session baseline: identity, source model, XeLaTeX-only support, keyed APIs, build/test commands, dependencies, version, and immediate watchpoints.

## overview
- `llmdoc/overview/project-overview.md` — project purpose, v2.0.0 modernization status, repository-shape changes, compatibility philosophy, and current project boundaries.

## architecture
- `llmdoc/architecture/class-architecture.md` — current class execution model: self-extracting DocStrip structure, expl3 naming, key spaces, compatibility layer, XeLaTeX-only runtime, front-matter flow, and maintenance invariants.

## reference
- `llmdoc/reference/modernization-reference.md` — stable v2.0.0 lookup for expl3 modernization decisions, `sdu` key namespaces, `\sdusetup`, `l3build`, CTAN/TDS packaging layout, CI, documentation-driver choices, and compatibility policy.

## memory
- `llmdoc/memory/doc-gaps.md` — known documentation gaps, unresolved questions, and underdocumented behavior worth revisiting.

## Routing Hints
- Need repository identity, supported engine, or build facts: go to `must/project-essentials.md`.
- Need context on what changed in v2.0.0 and how the repository is organized now: go to `overview/project-overview.md`.
- Need to understand how the modern class actually works: go to `architecture/class-architecture.md`.
- Need quick lookup for option namespaces, compatibility policy, build commands, or CI files: go to `reference/modernization-reference.md`.
- Need to see what is still unclear or missing from docs: go to `memory/doc-gaps.md`.
