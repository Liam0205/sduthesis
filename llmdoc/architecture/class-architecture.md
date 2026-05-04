# Class Architecture

## Scope
This document covers the stable execution model of the `v2.0.0` `sduthesis` class: self-extracting DocStrip structure, expl3 class declaration, option and metadata key spaces, package/loading boundaries, XeLaTeX-only assumptions, front-matter composition, compatibility shims, and the current test-backed maintenance boundary.

## 1. DocStrip Structure
The project is still generated from one documented source file, `sduthesis.dtx`, but the installer boundary changed.

Current guards and outputs:
- `class` -> `sduthesis.cls`
- `cover` -> `sduthesis-cover.def`
- `statement` -> `sduthesis-statement.def`
- `demo` -> `sduthesis-demo.tex`
- `readme` -> `README.md`
- `license` -> `LICENSE.md`
- `driver` -> self-documentation driver code inside the `.dtx`

Extraction model:
- `sduthesis.ins` no longer exists
- `sduthesis.dtx` enters self-extracting mode when `\documentclass` is undefined
- the extraction branch uses `l3docstrip.tex`
- `l3build unpack` is now the standard extraction entrypoint

Architecture implication:
- edits still target `sduthesis.dtx`, not generated outputs
- runtime behavior is still split across the generated class plus two generated `.def` files
- front matter is still not a separate package; it remains hard-wired into the generated class outputs
- extraction is now part of the `.dtx` contract itself rather than a separate `.ins` file contract

## 2. Runtime Composition Model
At runtime the generated class behaves like this:
1. declare the class with `\ProvidesExplClass`
2. establish expl3 module naming with DocStrip prefix `@@=sdu`, generating the `__sdu` internal namespace
3. define load-time option keys under `sdu / option`
4. define user metadata/runtime keys under `sdu / info`
5. process class options with `l3keys`-based machinery
6. load `ctexbook` as the base class with the resolved class-level state
7. load local layout/math/table/graphics support needed by the class implementation
8. input `sduthesis-cover.def` and `sduthesis-statement.def`
9. expose combined commands that orchestrate cover, statement, front matter, and TOC flow

This keeps `sduthesis` as a focused wrapper over `ctexbook`, but the wrapper is now explicit and structured rather than relying on legacy forwarding behavior.

## 3. expl3 Identity and Naming Model
### Class declaration
The class now follows an expl3-native top-level identity:
- use `\ProvidesExplClass` rather than legacy `\ProvidesClass`
- use expl3 naming conventions in the implementation
- keep the source readable through the DocStrip `@@` convention

### Prefix mapping
The implementation uses module prefix `sdu`.

Stable naming consequences:
- source-side private names use the `@@` convention
- generated internal names expand into the `__sdu` namespace
- public/project-level identifiers stay under the `sdu` family

This is the main internal-namespace boundary contributors should expect when reading generated code or writing new implementation blocks.

## 4. Option System in v2.0.0
### Load-time option namespace
Class options are defined under `sdu / option` and processed with `l3keys`.

The current stable option surface includes modern keys such as:
- `style`
- `print`
- `twoside`
- `degree`

The important architecture change is not only the option names, but the processing model:
- no `kvoptions`
- no legacy default-option forwarding as the primary contract
- validation and compatibility handling can now be centralized in one keyed system

### Degree extensibility
`degree` is architected as more than a bachelor-only literal. The stable contract already reserves `master` and `doctor` as extension points, even if the project's present feature emphasis remains the bachelor-thesis layout.

## 5. Public Metadata API
### Primary setup surface
The main public metadata API is now:
- `\sdusetup{info={...}}`

Metadata keys live under `sdu / info`.

Typical information carried through this path includes:
- title
- author
- student id
- school
- major
- grade
- supervisor
- date

### Architecture consequence
The class no longer treats metadata primarily as a bag of independent token-register setter commands. Instead, structured keys define the stable input surface, which improves:
- discoverability
- validation potential
- deprecation handling
- future growth for additional thesis types or front-matter variants

## 6. Compatibility Layer
### Deprecated metadata commands
Historical commands such as `\Ctitle`, `\Cauthor`, and related setter macros are still accepted.

Current contract:
- legacy commands are compatibility shims, not the preferred API
- use of legacy commands should emit deprecation warnings
- durable new documentation should prefer the keyed `\sdusetup` interface

### Deprecated class options
Historical options such as:
- `chsstyle`
- `nochsstyle`
- `print`
- `noprint`
- `double`
- `single`

are still accepted for compatibility, but they are no longer the architectural center. They should be understood as aliases or migration bridges toward the modern option layer.

### Architecture consequence
Compatibility is now explicit local logic rather than accidental survival through unknown-option forwarding. That is a major change in ownership: `sduthesis` itself now owns its compatibility story.

## 7. Base-Class Loading Boundary
`sduthesis` remains layered on `ctexbook`.

What `sduthesis` still owns locally:
- project-specific option mapping and metadata normalization
- cover and statement orchestration
- local page-layout and front-matter conventions
- project-specific helper commands and presentation details

What `ctexbook` still owns:
- the broader Chinese typesetting ecosystem behavior
- much of the underlying CJK/font machinery
- base book-class semantics and large parts of document-structure behavior

The modernization clarified this boundary by removing a large amount of implicit option forwarding and replacing it with explicit project-owned keys.

## 8. Engine Model
### Supported engine
The stable supported engine is now XeLaTeX only.

Architecture consequences:
- historical pdfTeX/DVI branches are no longer part of the supported runtime contract
- engine selection is no longer a soft preference from build scripts; it is a class-level project assumption
- font and graphics expectations can be written against one engine family instead of multiple compatibility branches

### Build alignment
The architecture, build configuration, tests, and documentation driver are aligned around XeLaTeX:
- `build.lua` sets XeTeX/XeLaTeX as the standard engine path
- CI runs `l3build check`
- the user-facing README describes XeLaTeX-only use

## 9. Package and Documentation Driver Model
### Runtime package layer
The runtime class still loads local support for layout, graphics, math, and table presentation around the `ctexbook` base.

The important architecture shift is that these choices are now made from within an expl3-oriented class rather than a LaTeX2e + `kvoptions` shell.

### Documentation driver layer
The `.dtx` driver now uses:
- `ctxdoc`
- explicit Noto CJK font selection
- `longtable` + `booktabs`
- a polyfill for `ctxdoc` up to `v2.5.x` against `l3doc` 2025+ changes

This driver behavior is part of the architectural picture because the project continues to use one file as both implementation source and user/developer documentation source.

## 10. Front-Matter Architecture
### Generated front-matter files
Front matter is still emitted as separate generated files:
- `sduthesis-cover.def`
- `sduthesis-statement.def`

### Composition workflow
The stable workflow command remains:
- `\maketitlepagestatement`

Its role is still to orchestrate:
- title/cover page generation
- originality and authorization statements
- front-matter sequencing before the main body flow

### Metadata flow change
What changed is not the existence of cover/statement outputs, but how they receive project metadata:
- old architecture: mostly independent setter commands and token-style state
- current architecture: keyed metadata input through `\sdusetup`, with legacy setters bridged through compatibility code where needed

## 11. Build, Test, and Packaging Architecture
### Standard maintenance commands
The stable maintenance workflows are now:
- `l3build unpack`
- `l3build check`
- `l3build doc`
- `l3build ctan`

### Test suite boundary
Regression tests live in `testfiles/` and currently include dedicated fixtures for:
- options
- info metadata
- compatibility

Architecture implication:
- option parsing and metadata handling are now part of the regression-protected surface
- compatibility behavior is no longer undocumented folklore; it has an explicit place in the quality model

### CI boundary
GitHub Actions installs TeX dependencies from `.github/tl_packages` and runs `l3build check`.

This makes testing part of the repository's stable execution model rather than a maintainer-only local habit.

## 12. Legacy Script Boundary
`build-legacy.sh` and `build-legacy.bat` remain in the repository, but they no longer define the primary build architecture.

Their current meaning is historical compatibility:
- they preserve a manual-script path for users familiar with older releases
- they are secondary to `l3build`
- new documentation should not treat them as the canonical workflow unless a task is specifically about legacy build support

## 13. Main Invariants for Contributors
- `sduthesis.dtx` remains the only real implementation source
- generated `.cls` and `.def` files are products, not editing targets
- public configuration should be designed around `sdu / option`, `sdu / info`, and `\sdusetup`
- private implementation names should stay within the `__sdu` namespace generated from the `@@=sdu` source convention
- XeLaTeX-only support is a stable project invariant
- compatibility shims may exist, but they should not displace the modern public API in new work
- tests should accompany changes to options, metadata, or compatibility behavior when practical

## 14. Architecture Debt and Remaining Questions
The v2.0.0 modernization removed most of the old architectural center, but some durable questions remain:
- how far master/doctor support should eventually extend beyond the reserved `degree` option values
- how long legacy setters and option aliases should remain in the public compatibility surface
- whether all old metadata fields have a meaningful rendering path in the new front-matter model
- whether the current test suite should later add more layout-sensitive assertions for cover and statement output

These are no longer blockers for understanding the architecture. They are now follow-up design questions inside an already-modernized class system.
