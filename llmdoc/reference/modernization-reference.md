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

Repository files that define this boundary:
- `build.lua`
- `DEPENDS.txt`

### Current `build.lua` packaging contract
Stable `build.lua` facts after the CTAN/TDS layout fix:
- `sourcefiles = {"*.dtx", "figures/*.pdf", "figures/*.jpg"}` so the flat CTAN package includes image assets alongside the `.dtx`
- `installfiles = {"*.cls", "*.def", "SDU.pdf", "SDULogo.pdf", "SDUWords.jpg", "sduthesis-*.jpg"}` because `l3build` flattens `figures/` assets into the unpack directory before TDS assembly
- `tdslocations` explicitly routes those flattened image files into `tex/latex/sduthesis/figures/`
- `docfiles = {"DEPENDS.txt"}` and `textfiles = {"README.md"}` place dependency and readme material in the documentation payload
- `excludefiles` excludes `AGENTS.md`, `CLAUDE.md`, and `build-legacy.*` from release archives
- `typesetfiles = {"*.dtx"}` keeps typesetting centered on the documented source
- `packtdszip = true` makes `l3build ctan` embed a TDS zip inside the CTAN release zip

### Resulting release structure
Stable release layout expectations:
- CTAN zip: flat package containing `.dtx`, generated PDF manual, `README.md`, `DEPENDS.txt`, figure assets, and the TDS zip
- TDS zip: `tex/latex/sduthesis/` for `.cls`, `.def`, and `figures/`; `source/latex/sduthesis/` for `.dtx`; `doc/latex/sduthesis/` for the manual PDF, `README.md`, and `DEPENDS.txt`

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

What this means:
- option parsing is part of the protected contract
- metadata-key behavior is part of the protected contract
- compatibility shims are part of the protected contract

This is a major change from the pre-v2.0.0 state, where behavior was largely inferred from source reading and manual compilation.

## 7. CI Reference
CI now exists in GitHub Actions.

Repository files:
- `.github/workflows/test.yml`
- `.github/tl_packages`

Stable workflow shape:
- trigger on pushes to `master`
- trigger on pull requests to `master`
- allow manual dispatch
- install TeX Live packages from `.github/tl_packages`
- run `l3build check`
- upload regression diff artifacts on failure

This makes automated regression checking part of the documented repository contract.

## 8. Documentation Driver Reference
The documentation driver embedded in `sduthesis.dtx` moved to a modernized toolchain.

Stable facts:
- driver class: `ctxdoc`
- compatibility shim: polyfill for `ctxdoc` up to `v2.5.x` with `l3doc` 2025+
- CJK fonts: Noto CJK family
- table tools: `longtable` + `booktabs`
- `tabu` was removed from the documentation-driver path

Why this matters:
- the user manual build no longer depends on the old `ltxdoc` + `ctexcap` approach
- documentation compilation is aligned with the modern expl3-oriented maintenance model

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
