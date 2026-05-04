# Rewrite user-facing `sduthesis.dtx` documentation for v2.0.0

## Task
- Rewrite the user manual sections embedded in `sduthesis.dtx` so they describe the current v2.0.0 expl3 implementation instead of the pre-modernization interface.

## Expected vs Actual
- Expected outcome.
  - The `.dtx` manual should match the shipped class behavior: XeLaTeX-only, `l3build` workflow, keyed class options and `\sdusetup` metadata, current generated files, and compatibility mappings.
- Actual outcome.
  - The documentation now matches the code and build system. Stale `sduthesis.ins`, pdfTeX/DVI, and `\Ctitle`-first guidance were removed or reframed as compatibility notes. `l3build doc` succeeded and `l3build check` passed all 6 regression tests before commit `9a4d381`.

## What Went Wrong
- User documentation had drifted behind a major architectural rewrite and was still teaching obsolete workflows and APIs.
- Some items previously tracked as doc gaps became partially outdated once the manual started documenting the keyed API, class options, metadata keys, and compatibility mappings.

## Root Cause
- The v2.0.0 expl3 rewrite changed the public surface substantially, but there was no explicit doc-verification checkpoint to ensure the embedded manual was updated in the same pass.

## Missing Docs or Signals
- The release process lacks an explicit step to verify that user-facing `.dtx` documentation still matches the implemented public API after major rewrites.
- `release.yml` exists in the repository surface, but the stable llmdoc set still does not capture that workflow.

## Promotion Candidates
- Stable docs candidate: add a release-checklist item requiring documentation/API verification after interface or build-workflow rewrites.
- Stable docs candidate: document the repository release workflow, including `release.yml`, in llmdoc reference or guide material.
- Memory only: review `llmdoc/memory/doc-gaps.md` after major documentation rewrites so partially resolved gaps are pruned or narrowed.

## Follow-up
- Update stable llmdoc to record the release workflow and add a documentation-verification step to release guidance/checklists.
