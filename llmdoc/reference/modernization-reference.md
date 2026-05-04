# v2.0.0 Modernization Reference

## Purpose
This reference is no longer a planning note for a future modernization. It is the stable lookup document for the modernization decisions that define the `v2.0.0` line of `sduthesis`: expl3 structure, keyed APIs, self-extracting DocStrip behavior, `l3build`, CI, documentation-driver choices, and compatibility policy.

## 1. Core Architecture Decisions
### expl3-native class
`sduthesis` now uses an expl3-native class architecture.

Stable facts:
- the class is declared with `\ProvidesExplClass`
- the implementation uses DocStrip module prefix `@@=sdu`
- generated internal names live in the `__sdu` namespace
- local option and metadata handling are built around `l3keys`

Why this matters:
- implementation ownership is clearer
- public and private namespaces are explicit
- validation and deprecation behavior can be centralized instead of scattered across legacy macros

### XeLaTeX-only runtime
The project now supports XeLaTeX only.

Stable consequences:
- no supported pdfTeX path
- no supported DVI graphics path
- build, test, documentation, and README assumptions can align on one engine family

## 2. Key Namespace and Public API Reference
### Load-time options
The class-load key namespace is:
- `sdu / option`

The modern documented options include:
- `style = chinese | plain`
- `print = true | false`
- `twoside = true | false`
- `degree = bachelor | master | doctor`

### Metadata/runtime setup
The user metadata namespace is:
- `sdu / info`

The main public API is:
- `\sdusetup{info={...}}`

Typical stable metadata keys include:
- `title`
- `author`
- `student-id`
- `school`
- `major`
- `grade`
- `supervisor`
- `date`

### Extension model
The keyed design is intentionally more extensible than the old setter-command model. In particular:
- `degree` already reserves non-bachelor values as extension points
- new metadata can be added under `sdu / info` without multiplying one-off commands
- compatibility aliases can be localized to key definitions or adapter code

## 3. Compatibility Reference
### Deprecated metadata setters
Historical user commands such as `\Ctitle`, `\Cauthor`, and similar setters remain accepted.

Stable policy:
- they are preserved for migration compatibility
- they emit deprecation warnings
- new examples and durable docs should prefer `\sdusetup{info={...}}`

### Deprecated class options
Historical options such as:
- `chsstyle`
- `nochsstyle`
- `print`
- `noprint`
- `double`
- `single`

remain accepted as compatibility inputs.

Stable policy:
- these aliases emit deprecation warnings where appropriate
- the canonical modern surface is the keyed option layer
- compatibility behavior is intentional project logic, not accidental fallback through unknown-option forwarding

## 4. Source and Extraction Reference
### Source of truth
The only implementation source remains:
- `sduthesis.dtx`

### Self-extracting behavior
`sduthesis.ins` has been removed.

Stable extraction model:
- `sduthesis.dtx` detects self-extract mode using `\ifx\documentclass\undefined`
- extraction uses `l3docstrip.tex`
- generated outputs include `sduthesis.cls`, `sduthesis-cover.def`, `sduthesis-statement.def`, `sduthesis-demo.tex`, `README.md`, and `LICENSE.md`

Practical implication:
- maintainers should edit `sduthesis.dtx`
- extraction is normally driven through `l3build unpack`
- the older `.ins`-based retrieval model should no longer be documented as current behavior

## 5. Build System Reference
The primary build and maintenance system is now `l3build`.

Stable commands:
- `l3build unpack` — extract `.cls` and `.def` outputs from `sduthesis.dtx`
- `l3build check` — run regression tests
- `l3build doc` — compile user documentation
- `l3build ctan` — create CTAN release packages
- `l3build tag <version>` — bump release metadata in tagged files before a release commit or archive build

Repository files that define this boundary:
- `build.lua`
- `DEPENDS.txt`
- `CHANGELOG.md`

### Current `build.lua` packaging and release contract
Stable `build.lua` facts after the thuthesis-aligned engineering pass:
- `sourcefiles = {"*.dtx", "figures/*.pdf", "figures/*.jpg"}` so the flat CTAN package includes image assets alongside the `.dtx`
- `installfiles = {"*.cls", "*.def", "SDU.pdf", "SDULogo.pdf", "SDUWords.jpg", "sduthesis-*.jpg"}` because `l3build` flattens `figures/` assets into the unpack directory before TDS assembly
- `tdslocations` explicitly routes those flattened image files into `tex/latex/sduthesis/figures/`
- `docfiles = {"DEPENDS.txt", "CHANGELOG.md"}` places dependency and changelog material in the documentation payload
- `textfiles = {"README.md"}` places the extracted readme in the documentation payload
- `excludefiles` excludes `AGENTS.md`, `CLAUDE.md`, and `build-legacy.*` from release archives
- `typesetfiles = {"*.dtx"}` keeps typesetting centered on the documented source
- `typesetdemofiles = {"sduthesis-demo.tex"}` makes the extracted demo part of the documentation typesetting set
- `packtdszip = true` makes `l3build ctan` embed a TDS zip inside the CTAN release zip

### Tag automation contract
`build.lua` now owns release-tag metadata updates through:
- `tagfiles = {"*.dtx", "CHANGELOG.md"}`
- `update_tag(file, content, tagname, tagdate)`

Stable behavior:
- tagging rewrites version/date strings inside `sduthesis.dtx`
- tagging updates the copyright year range in the `.dtx`
- tagging inserts a new version heading into `CHANGELOG.md`
- tagging rewrites changelog compare links from the previous release to the new tag

Practical implication:
- maintainers should treat `l3build tag <version>` as the canonical release-metadata update path
- manual version bumps in the `.dtx` and changelog should stay consistent with this hook logic

### Documentation typesetting hook contract
`build.lua` now uses `docinit_hook()` to stage extra documentation assets before typesetting.

Stable behavior:
- copies `sduthesis-demo.tex` from the unpack directory into the typeset directory
- copies `figures/*.pdf` and `figures/*.jpg` into the typeset directory
- allows the extracted demo document to compile during documentation builds
- ensures the CTAN documentation payload includes the demo PDF produced from the extracted example source

Practical implication:
- demo compilation is now part of the maintained documentation pipeline rather than an ad-hoc manual step
- figure availability in the typeset directory is a stable precondition for successful doc/demo builds

### Resulting release structure
Stable release layout expectations:
- CTAN zip: flat package containing `.dtx`, generated PDF manual, `README.md`, `DEPENDS.txt`, `CHANGELOG.md`, figure assets, demo PDF, and the TDS zip
- TDS zip: `tex/latex/sduthesis/` for `.cls`, `.def`, and `figures/`; `source/latex/sduthesis/` for `.dtx`; `doc/latex/sduthesis/` for the manual PDF, demo PDF, `README.md`, `DEPENDS.txt`, and `CHANGELOG.md`

This layout matches the standard CTAN pattern used by `thuthesis`: a flat upload archive plus a correctly structured TDS archive for TeX distribution installation.

### Legacy script status
The repository still contains:
- `build-legacy.sh`
- `build-legacy.bat`

These are historical compatibility helpers, not the canonical workflow.

## 6. Regression Test Reference
Regression tests now live in `testfiles/`.

Current stable fixtures include:
- `test-options.lvt` / `test-options.tlg`
- `test-info.lvt` / `test-info.tlg`
- `test-compat.lvt` / `test-compat.tlg`
- `test-cover.lvt` / `test-cover.tlg`
- `test-statement.lvt` / `test-statement.tlg`
- `test-abstract.lvt` / `test-abstract.tlg`

What this means:
- option parsing is part of the protected contract
- metadata-key behavior is part of the protected contract
- compatibility shims are part of the protected contract
- cover-page rendering is part of the protected contract
- statement-page rendering is part of the protected contract
- Chinese and English abstract environment rendering is part of the protected contract

This is a major change from the pre-v2.0.0 state, where behavior was largely inferred from source reading and manual compilation.

## 7. CI and Collaboration Surface Reference
CI now exists in GitHub Actions, and repository-level issue intake is now partially structured through GitHub issue templates.

Repository files:
- `.github/workflows/test.yml`
- `.github/tl_packages`
- `.github/ISSUE_TEMPLATE/bug-report.yml`
- `.github/ISSUE_TEMPLATE/config.yml`

Stable workflow shape:
- trigger on pushes to `master`
- trigger on pull requests to `master`
- allow manual dispatch
- install TeX Live packages from `.github/tl_packages`
- run `l3build check`
- upload regression diff artifacts on failure

Stable collaboration facts:
- bug intake now uses a structured issue form that captures class version, TeX distribution, operating system, and a minimal working example
- issue-template config redirects general usage questions toward GitHub Discussions instead of the bug tracker
- the repository now treats support routing as part of its maintained engineering surface, not only an informal convention

This makes automated regression checking and issue triage part of the documented repository contract.

## 8. Documentation Driver Reference
The documentation driver embedded in `sduthesis.dtx` moved to a modernized toolchain.

Stable facts:
- driver class: `ctxdoc`
- compatibility shim: polyfill for `ctxdoc` up to `v2.5.x` with `l3doc` 2025+
- CJK fonts: Noto CJK family
- table tools: `longtable` + `booktabs`
- `tabu` was removed from the documentation-driver path
- the user-facing manual in `sduthesis.dtx` was rewritten after the expl3 migration and is now aligned with the `v2.0.0` implementation surface
- that manual now documents the expl3/l3keys/l3build introduction, the self-extracting `.dtx` model, current file layout, canonical class options, `\sdusetup{info={...}}` quick-start usage, compatibility mappings, cover/statement and abstract commands, math helpers, and the XeLaTeX-only compilation requirement

Why this matters:
- the user manual build no longer depends on the old `ltxdoc` + `ctexcap` approach
- documentation compilation is aligned with the modern expl3-oriented maintenance model
- the shipped manual is now a reliable user-facing description of the current `v2.0.0` API rather than a legacy-era snapshot

## 9. Repository Rename and Structure Reference
Stable repository-level naming changes in the modernization:
- `README` -> `README.md`
- `build` -> `build-legacy.sh`
- `build.bat` -> `build-legacy.bat`
- added `build.lua`
- added `DEPENDS.txt`
- added `.github/workflows/test.yml`
- added `.github/tl_packages`
- added regression files under `testfiles/`

These changes matter for retrieval because older notes or user habits may still refer to the pre-v2.0.0 names.

## 10. What This Document Is For
Use this document when you need quick stable lookup for:
- the meaning of the v2.0.0 modernization
- the canonical option and metadata namespaces
- the current build/test/CI workflow names
- the compatibility bridge policy
- the repository files that define the modern maintenance model

Use `llmdoc/architecture/class-architecture.md` when the question is about runtime flow or ownership boundaries inside the class. Use `llmdoc/overview/project-overview.md` when the question is about project identity and repository-level state.
