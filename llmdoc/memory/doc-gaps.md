# Documentation Gaps

## Class Behavior Gaps
- The v2.0.0 docs now establish `style`, `print`, `twoside`, and `degree` as the canonical class options, and the user manual in `sduthesis.dtx` now documents those options with descriptions. llmdoc still lacks a compact reference table for the full `sdu / option` surface.
- `degree` already reserves `master` and `doctor` values, but the behavioral scope attached to those values is not yet documented as a stable user contract.
- The user manual now includes a compatibility mapping table for deprecated metadata setters and old options/commands, but llmdoc still does not summarize that mapping as a dedicated reference surface.

## Front-Matter Gaps
- The user manual now documents the cover, statement, abstract, and math command surfaces, and it describes the metadata used by the current templates. llmdoc still does not enumerate every supported `sdu / info` key as a compact lookup table, nor does it map each key to its rendering target.
- It is still worth documenting whether any historical metadata fields remain intentionally reserved but visually unused in the current cover layout.
- The long-term plan for non-bachelor front-matter variants under the reserved `degree` extension points is not yet documented.

## Build and Quality Gaps
- CI currently documents only the regression-test workflow; the release workflow in `.github/workflows/release.yml` is still not captured in llmdoc. Stable facts still needing documentation: it triggers on `v*` tags, builds the CTAN zip, generates release notes, waits for test CI, and creates a GitHub prerelease.
- The project now has `DEPENDS.txt` and `.github/tl_packages`, but the ownership rule for keeping those dependency lists in sync is not yet documented.
- A dedicated workflow guide is still missing for validating CTAN/TDS packaging end to end, even though the stable release layout is now documented.
- The release checklist around `l3build tag <version>`, changelog curation, and archive verification is still undocumented as a step-by-step guide.
- The new front-matter regression fixtures prove coverage for cover, statement, and abstract rendering, but the precise invariants each fixture protects are not yet summarized in one durable guide.

## Documentation-System Gaps
- No guide documents exist yet for the new `l3build`-based workflows, even though the modernization made them part of the stable maintenance model.
- llmdoc still lacks a compact lookup document for the full `sdu / option` and `sdu / info` inventories, even though the user manual now covers the current class options and metadata keys in prose.
- The issue-template and Discussions routing policy is now part of the repository surface, but there is no contributor guide yet explaining when maintainers should redirect reports versus accept them as bugs.
