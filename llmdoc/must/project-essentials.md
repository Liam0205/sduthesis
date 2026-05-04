# Project Essentials

## Identity
- Project: `sduthesis`
- Purpose: Shandong University thesis template for LaTeX, currently centered on bachelor-thesis workflows with reserved extensibility for higher degrees
- Source model: single-source DocStrip project centered on `sduthesis.dtx`
- License: LPPL 1.3c or later, maintenance status `maintained`
- Maintainer: Liam Huang
- Current published class version: `v2.0.0` (`2026/05/04`)
- Repository state: major modernization completed; expl3, `l3keys`, `l3build`, regression tests, and CI are now part of the stable baseline

## Core Stack
- Language/runtime: expl3-based LaTeX class + DocStrip
- Base class: `ctexbook`
- Supported engine: XeLaTeX only
- Option system: `l3keys` with class options under `sdu / option`
- Metadata/runtime setup: `l3keys` with public `\sdusetup{info={...}}`
- Build/test/release tool: `l3build`

## Source of Truth
- `sduthesis.dtx`: documented source for class, cover, statement, demo, README, license, and documentation driver
- `build.lua`: `l3build` configuration
- `DEPENDS.txt`: dependency declaration for the build/test toolchain
- `CHANGELOG.md`: Keep a Changelog release history and compare-link source
- `.github/workflows/test.yml`: CI workflow
- `.github/tl_packages`: TeX Live package list for CI
- `.github/ISSUE_TEMPLATE/`: structured issue intake and discussion routing

## Generated Outputs
- `sduthesis.cls`: main class
- `sduthesis-cover.def`: cover-page definitions
- `sduthesis-statement.def`: originality/authorization statement definitions
- `sduthesis-demo.tex`: example thesis document
- `README.md` and `LICENSE.md`: extracted text deliverables
- `sduthesis.pdf`: user manual from the `.dtx` driver

## Repository Structure
- `sduthesis.dtx`: only real implementation source
- `build.lua`: canonical build/test/package entrypoint definition
- `build-legacy.sh`, `build-legacy.bat`: legacy manual build helpers kept for compatibility
- `figures/`: cover and demo image assets
- `testfiles/`: regression fixtures and expected logs, including front-matter and abstract coverage
- `.github/ISSUE_TEMPLATE/`: structured bug-report intake and discussion routing
- `llmdoc/`: durable project documentation
- `.llmdoc-tmp/investigations/`: temporary investigation notes, not stable docs

## Build Commands
- Extract runtime files: `l3build unpack`
- Run regression tests: `l3build check`
- Build user documentation: `l3build doc`
- Build CTAN package archives: `l3build ctan`
- Update release metadata before tagging: `l3build tag <version>`

## Packaging Facts
- `build.lua` treats `sduthesis.dtx` plus `figures/*.pdf` and `figures/*.jpg` as CTAN source inputs so image assets are copied into the flat CTAN package.
- `docfiles` ships both `DEPENDS.txt` and `CHANGELOG.md`; `textfiles` ships `README.md`.
- `tagfiles = {"*.dtx", "CHANGELOG.md"}` lets `l3build tag <version>` update release metadata in both the documented source and changelog.
- `typesetdemofiles = {"sduthesis-demo.tex"}` plus `docinit_hook()` make the extracted demo compile into a PDF for the CTAN documentation payload.
- `installfiles` only matches generated runtime files plus flattened image filenames in the unpack directory: `*.cls`, `*.def`, `SDU.pdf`, `SDULogo.pdf`, `SDUWords.jpg`, and `sduthesis-*.jpg`.
- `tdslocations` sends those flattened image assets to `tex/latex/sduthesis/figures/` inside the TDS zip.
- `docfiles` ships `DEPENDS.txt`; `textfiles` ships `README.md`.
- `excludefiles` keeps `AGENTS.md`, `CLAUDE.md`, and `build-legacy.*` out of release archives.
- `typesetfiles = {"*.dtx"}` keeps documentation build focused on the `.dtx` driver.

## Build Pipeline
1. `l3build unpack` extracts generated runtime and documentation-side outputs from `sduthesis.dtx`
2. `l3build check` runs regression tests in `testfiles/`
3. `l3build doc` compiles the user manual from the `ctxdoc` driver in `sduthesis.dtx`
4. `l3build ctan` assembles a CTAN flat zip plus an embedded TDS zip
5. The TDS zip places `.cls`, `.def`, and figure assets under `tex/latex/sduthesis/`, source `.dtx` under `source/latex/sduthesis/`, and documentation deliverables under `doc/latex/sduthesis/`

## Key Dependencies
- expl3/toolchain: `l3kernel`, `l3packages`, `l3backend`, `l3keys2e`, `l3build`
- Base Chinese typesetting: `ctex`, `xecjk`, `fontspec`
- Base class: `ctexbook`
- Layout/graphics: `geometry`, `graphicx`, `xcolor`, `hyperref`, `fancyhdr`
- Math: `amsmath`, `amscls`, `amsfonts`, `bm`, `mathrsfs`
- Tables/docs: `booktabs`, `makecell`, `longtable`
- Documentation driver support: `ctxdoc`, Noto CJK fonts available to XeLaTeX

## Runtime Model
- The class is an expl3-based wrapper over `ctexbook`
- Internal names are generated under the `__sdu` namespace from the source prefix `@@=sdu`
- Cover and statement pages are still loaded from separate generated `.def` files
- User metadata is configured through keyed setup rather than only through legacy setter commands
- Compatibility aliases remain available but warn on deprecated use

## Current High-Signal Facts
- canonical class options include `style`, `print`, `twoside`, and `degree`
- canonical metadata entrypoint is `\sdusetup{info={...}}`
- legacy commands such as `\Ctitle` and `\Cauthor` are still supported with deprecation warnings
- legacy options such as `chsstyle`, `noprint`, `double`, and `single` are still supported with deprecation warnings
- `degree` already reserves `master` and `doctor` extension points
- CI runs `l3build check` on GitHub Actions
- regression baselines exist for options, info metadata, compatibility, cover generation, statement generation, and abstract environments

## Immediate Watchpoints
- new work should document and prefer the keyed API, not the legacy setter surface
- legacy scripts remain in-repo but should not be treated as the primary build workflow
- documentation-driver compatibility currently relies on a ctxdoc polyfill for `ctxdoc` up to `v2.5.x`
- `DEPENDS.txt` and `.github/tl_packages` should stay aligned when build/test dependencies change
