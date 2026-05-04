# Project Overview

## Identity and Purpose
`sduthesis` is a LaTeX thesis template for Shandong University. In the current `v2.0.0` line, it is a modernized bachelor-thesis class built on top of `ctexbook`, with university-specific cover pages, originality/authorization statements, abstract environments, heading presets, and a small set of mathematical convenience commands.

The project still follows a compact single-source `.dtx` model, but the implementation has crossed a major architectural boundary: the class was rewritten around expl3 conventions, `l3keys`, `l3build`, and CI-backed regression testing.

## Project Status in v2.0.0
The repository is no longer best described as a dormant legacy template waiting for modernization. The major modernization step has already landed.

High-signal state changes in `v2.0.0`:
- the class implementation moved from LaTeX2e + `kvoptions` idioms to an expl3-native structure
- class/load-time options now live under `sdu / option`
- document metadata/runtime setup now lives under `sdu / info` and is exposed through `\sdusetup{info={...}}`
- the generated code uses the `sdu` DocStrip module prefix, which expands internals into the `__sdu` namespace
- only XeLaTeX is supported; legacy pdfTeX/DVI branches are no longer part of the supported runtime contract
- build, test, and release packaging now center on `l3build`
- CI and regression baselines now exist in-repo

## What the Project Is Today
At runtime, `sduthesis` is still a focused wrapper around `ctexbook`, but it is no longer a thin legacy layer with ad-hoc state.

Today the project is better understood as:
- an expl3-based thesis class whose durable source of truth is `sduthesis.dtx`
- a single-source DocStrip project with self-extracting behavior when the `.dtx` is run outside a LaTeX document context
- a XeLaTeX-only workflow with explicit modern toolchain assumptions
- a tested class with regression fixtures for option parsing, metadata handling, and compatibility behavior
- a project whose public setup surface is converging on `\sdusetup`, while selected historical interfaces remain available as deprecated compatibility shims

## Core Modernization Outcomes
### expl3 rewrite
The old class architecture based on LaTeX2e-style imperative setup and `kvoptions` has been replaced by an expl3-native class declaration model. This moves the project from incidental compatibility with modern LaTeX conventions to an explicit adoption of them.

### Keyed public API
The most important user-facing API change is the shift from a collection of independent metadata setter commands toward keyed configuration:
- load-time options: `sdu / option`
- metadata/runtime setup: `sdu / info`
- public entrypoint: `\sdusetup{info={...}}`

This creates a clearer contract for validation, deprecation, and future extension.

### XeLaTeX-only support
The historical engine branching has been removed from the supported model. The class now assumes XeLaTeX, which simplifies font behavior, graphics handling, and documentation/build expectations.

### l3build-based maintenance
The project no longer relies on repository-local ad-hoc build scripts as its primary maintenance path. Instead, `l3build` defines the main workflows for extraction, testing, documentation build, and CTAN packaging.

## Repository Shape After Modernization
Key repository-level changes:
- `sduthesis.ins` was removed; extraction is now handled from `sduthesis.dtx` itself through the `\ifx\documentclass\undefined` path
- `build` became `build-legacy.sh`
- `build.bat` became `build-legacy.bat`
- `README` became tracked as `README.md`
- `build.lua` now defines the `l3build` configuration
- `DEPENDS.txt` declares required package dependencies
- `.github/workflows/test.yml` and `.github/tl_packages` provide CI and TeX Live package installation
- `testfiles/` now contains regression fixtures such as `test-options`, `test-info`, and `test-compat`

## Deliverable Relationship Diagram

```text
sduthesis.dtx
  ├─[self-extract mode]─> sduthesis.cls
  ├─[self-extract mode]─> sduthesis-cover.def
  ├─[self-extract mode]─> sduthesis-statement.def
  ├─[self-extract mode]─> sduthesis-demo.tex
  ├─[self-extract mode]─> README.md
  ├─[self-extract mode]─> LICENSE.md
  └─[driver]───────────> sduthesis.pdf via ctxdoc

build.lua
  ├─ l3build unpack -> extract generated runtime files
  ├─ l3build check  -> run regression tests in testfiles/
  ├─ l3build doc    -> compile user documentation
  └─ l3build ctan   -> build CTAN-ready release archives

.github/workflows/test.yml
  └─ installs TeX Live packages from .github/tl_packages
     and runs l3build check
```

## Documentation Driver Changes
The `.dtx` documentation driver also crossed a tooling boundary:
- it now uses `ctxdoc` instead of `ltxdoc` + `ctexcap`
- it includes a temporary ctxdoc polyfill for compatibility with `ctxdoc` up to `v2.5.x` and `l3doc` 2025+
- it selects Noto CJK fonts explicitly
- it replaced `tabu`-era table usage with `longtable` + `booktabs`

This matters because the documentation build is now aligned with the same modernization story as the class itself, rather than depending on older CTeX-era documentation machinery.

## Compatibility Philosophy in v2.0.0
The modernization is not a compatibility purge. The project keeps a transitional surface where it helps existing users:
- historical metadata commands such as `\Ctitle` and `\Cauthor` are still accepted but emit deprecation warnings
- historical class options such as `chsstyle` and `noprint` are still accepted but emit deprecation warnings
- the `degree` option already reserves extension points for `master` and `doctor`, even though the practical project focus remains bachelor-thesis workflows

The stable direction is clear: new usage should prefer `\sdusetup` and modern option names, while old interfaces remain only as a migration bridge.

## Current Boundaries
- Implementation source of truth: `sduthesis.dtx`
- Extraction boundary: self-extracting DocStrip logic inside `sduthesis.dtx`
- Runtime class boundary: generated `sduthesis.cls`
- Front-matter rendering boundary: generated `sduthesis-cover.def` and `sduthesis-statement.def`
- Example boundary: generated `sduthesis-demo.tex`
- Build/test/package boundary: `build.lua`, `DEPENDS.txt`, `testfiles/`, and `.github/workflows/test.yml`
- Legacy/manual-script boundary: `build-legacy.sh` and `build-legacy.bat`, preserved as historical compatibility helpers rather than the primary workflow

## Practical Reading of the Codebase
A contributor should now expect a codebase where:
- most behavior still lives in one `.dtx` file
- generated outputs are still not the place to edit
- public behavior is increasingly described through explicit key spaces instead of implicit legacy forwarding
- testing and CI are part of the stable maintenance model
- some user-visible behavior remains inherited from `ctexbook`, but local ownership is clearer than in the pre-2.0.0 design

## Current State Summary
`sduthesis` is now a modernized, actively maintainable single-source thesis template. Its core design remains intentionally compact, but its engineering model has changed substantially: expl3 naming and keys, XeLaTeX-only support, self-extracting `.dtx`, `l3build`, regression tests, and CI are now part of the stable project identity rather than future aspirations.
