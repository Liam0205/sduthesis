# Documentation Gaps

## Class Behavior Gaps
- The v2.0.0 docs now establish `style`, `print`, `twoside`, and `degree` as the canonical class options, but the exact removal timeline for deprecated option aliases is still undocumented.
- `degree` already reserves `master` and `doctor` values, but the behavioral scope attached to those values is not yet documented as a stable user contract.
- The exact coverage of deprecated metadata setters beyond the commonly referenced `\Ctitle`, `\Cauthor`, and similar commands should still be enumerated if long-term compatibility is important.

## Front-Matter Gaps
- The stable docs now describe keyed metadata via `\sdusetup{info={...}}`, but they do not yet enumerate every supported `sdu / info` key and whether each one is rendered on the current cover or statement pages.
- It is still worth documenting whether any historical metadata fields remain intentionally reserved but visually unused in the current cover layout.
- The long-term plan for non-bachelor front-matter variants under the reserved `degree` extension points is not yet documented.

## Build and Quality Gaps
- CI currently documents only the regression-test workflow; a stable release workflow beyond `l3build ctan` is still not captured in llmdoc.
- The project now has `DEPENDS.txt` and `.github/tl_packages`, but the ownership rule for keeping those dependency lists in sync is not yet documented.
- A dedicated workflow guide is still missing for validating CTAN/TDS packaging end to end, even though the stable release layout is now documented.

## Documentation-System Gaps
- No guide documents exist yet for the new `l3build`-based workflows, even though the modernization made them part of the stable maintenance model.
- No reference document yet lists the full `sdu / option` and `sdu / info` key inventory as a compact lookup surface.
