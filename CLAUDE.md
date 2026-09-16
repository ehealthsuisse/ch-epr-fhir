# CH EPR FHIR — working notes

FHIR R4 implementation guide for the Swiss EPR, published by eHealth Suisse.
It specifies Swiss national extensions to IHE ITI profiles and is referenced from the
profile table of Annex 5 EPRO-FDHA (Anhang 5 EPDV-EDI), which is revised annually.

**The specifications here are normative.** Every change must be checked against the original
IHE publications, not against plausibility. When a source is ambiguous, ask rather than assume.

## Build

```bash
sushi .
```

Must report 0 errors. SUSHI alone is **not** sufficient — it does not validate the examples
against the IHE profiles.

```bash
JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Duser.language=en -Duser.country=US" \
  java -jar input-cache/publisher.jar -ig .
```

Takes 15–20 minutes. Results land in `output/qa.txt`, `output/qa.html` and `output/qa.json`.

**The English locale is mandatory.** `input/ignoreWarnings.txt` contains English message
patterns. On a German-locale machine the publisher emits German messages, nothing matches,
and the warning count is meaningless — measured on an identical tree: 235 warnings /
29 suppressed (German) versus 53 / 211 (English).

Do not switch branches while the publisher is running; it reads the working tree.

Update the publisher with `_updatePublisher.bat` / `.sh`.

## Repository layout

| Path | Contents |
|---|---|
| `input/fsh/*.fsh` | profiles, extensions, examples, capability statements |
| `input/fsh/Aliases.fsh` | aliases for external canonical URLs |
| `input/pagecontent/*.md` | narrative, referenced standards, changelog |
| `input/resources/` | hand-written StructureDefinitions, ValueSets, SearchParameters |
| `input/ignoreWarnings.txt` | accepted QA warnings, with a comment giving the reason |
| `sushi-config.yaml` | dependencies, version, page structure, menu |

## Conventions

### One concern per pull request

One issue, one branch, one PR. When several IHE profiles are updated, **each profile gets its
own issue and its own PR** so that a later problem can be traced to a single change and
reverted on its own. Umbrella issues only reference the individual ones; no development
happens in them.

An unrelated defect found while working gets its own issue — it does not join the open branch.

Branch naming: `issue-<number>-<short-slug>`.

### Changelog

Every change gets an entry in `input/pagecontent/changelog.md`, and every entry carries an
issue number. The top section is the current cycle:

```
### DSTU<n> Informative Ballot <year>

#### Open Issues

* <PROFILE>: <why it is deferred> [#NNN](https://github.com/ehealthsuisse/ch-epr-fhir/issues/NNN)

#### Resolved Issues

* <PROFILE>: <what changed> [#NNN](https://github.com/ehealthsuisse/ch-epr-fhir/issues/NNN)
```

Profile prefixes in use: `IUA:`, `MHD:`, `mCSD:`, `ATC:`, `PPQm:`, `PIXm:`, `PDQm:`, `ATNA:`.
`#### Closed Issues` is for issues closed without a code change.
At the annual freeze the section is renamed to `### DSTU<n> Release <date>`.

### Version and date

`version` and `date` in `sushi-config.yaml` are **not** bumped per change. They move only at
the annual freeze, as a release decision.

### Review

Changes are prepared and verified locally, then opened as a PR. **Someone else reviews and
merges** — the author never merges their own change. This four-eyes rule is deliberate.

## Referencing IHE

- **FHIR R4 is fixed.** R5 is skipped. Check `fhirVersion` of any package before bumping it —
  for example `ihe.iti.mhd` 5.0.0 is R5 and cannot be used here.
- **Ballot and public-comment publications are not referenced** (e.g. `4.2.5-comment`).
  Only Final Text or Trial Implementation.
- Canonical IHE URLs such as `https://profiles.ihe.net/ITI/MHD/index.html` serve the newest
  publication, which during a ballot is the `-comment` version. Citations that name a specific
  revision must use the versioned URL, e.g. `/ITI/MHD/4.2.4/index.html`.
- Cite the **"Active as of"** date from the IG itself, not the "Revised" date on the ITI
  overview page — they differ.
- When bumping a dependency, also grep the narrative:
  `grep -rn "Rev\. " input/pagecontent/` — version references live in the text too.

To find out what an IHE update actually changed, diff the packages rather than trusting
changelog prose:

```bash
curl -sSL https://packages.simplifier.net/ihe.iti.mhd/4.2.4 -o mhd.tgz && tar -xzf mhd.tgz
```

Current package versions and their FHIR version: `curl -sS https://packages.fhir.org/ihe.iti.mhd`

## Pitfalls

- **No inline YAML comments on dependency lines in `sushi-config.yaml`.** The publisher's
  `prescanSushiConfig` does not strip them, turning `ch-core: 6.0.0 # current` into the URL
  `.../ch-core/6.0.0 # current` and aborting the build before any validation. SUSHI parses the
  same file correctly, so the failure is easy to miss. See #463.
- A green SUSHI run plus untouched `output/qa.*` files can mean the publisher never ran.
  Check the timestamps.
- Windows: `gh` is not on the PATH of shells opened before installation —
  `C:\Program Files\GitHub CLI\gh.exe`. Multi-line `--body` arguments fail through PowerShell;
  use `--body-file`.
