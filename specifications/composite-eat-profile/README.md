# OCP Composite EAT Profile for Platform Inventory Attestation

## Review version

The current rendered contribution is available for review as
[HTML](https://helloxiling.github.io/Security/composite-eat-profile/HEAD/) or
[PDF](https://helloxiling.github.io/Security/composite-eat-profile/HEAD/spec.pdf).
Its source is on the
[`xsun/composite-eat-profile` branch](https://github.com/helloxiling/Security/tree/xsun/composite-eat-profile/specifications/composite-eat-profile).

After this contribution is merged into the upstream `main` branch, the OCP
Pages workflow will publish the rendered specification at
`https://opencomputeproject.github.io/Security/composite-eat-profile/HEAD/`.

## Specification source

The specification source is available in [spec.ocp](./spec.ocp).

This document builds on the Composite EAT mechanism in
[`draft-sun-rats-composite-eat`](https://datatracker.ietf.org/doc/draft-sun-rats-composite-eat/)
and applies OCP constraints for platform inventory attestation. It carries
native Evidence as RFC 9999 Record CMWs in CWT claim 299, which differs from the
provisional claim used by `-00`. It uses a
distinct profile OID in claim 265. The working draft requests
`1.3.6.1.4.1.42623.1.4`; this proposed assignment remains pending OCP approval
and must not be treated as assigned until OCP confirms it. The existing OCP
Device EAT profile OID identifies that different profile and is not reused for
the Composite EAT main token.

A device-emitted EAT carried as Sub-Attester Evidence conforms to the OCP
Profile for IETF Entity Attestation Token. Sub-Attesters that supply native SPDM
Evidence are not required to emit EAT.

The machine-readable profile grammar is available in
[cddl/composite_eat_ocp_profile.cddl](./cddl/composite_eat_ocp_profile.cddl).
Its `concise-evidence-map` type is supplied by the TCG DICE Concise Evidence
Binding for SPDM CDDL.

## Building the specification

To view a rendered version of the specification, clone the
[ocp-spec-tools](https://github.com/opencomputeproject/ocp-spec-tools)
repository, and then run:

```sh
path/to/ocp-spec-tools/docker-pull.sh
bash render.sh path/to/ocp-spec-tools
```

Run this command from this directory, or set `OCP_SPEC_TOOLS` to the absolute
path of the tools checkout. It generates both `spec.html` and `spec.pdf`, with
numbered captions below the tables. The script uses the OCP renderer and then
moves its generated LaTeX captions outside `xltabular` to preserve bottom
borders and table numbering. It stops if the expected caption layout changes.
For the same template revision as CI, check out
`c28385a96b2643a8acb4df96fc6c020405db2c69` in `ocp-spec-tools`. The script
pins the Pandoc container by digest; `DOCKER_IMAGE` can override it for testing.

The rendered HTML and PDF are tracked review artifacts. Rebuild and commit
them with every source change. The profile date comes from `spec.ocp`, not the
build date.

On the fork's `xsun/composite-eat-profile` branch, the review publishing
workflow rebuilds the artifacts, checks HTML and extracted PDF text against
the committed copies, and refreshes the profile files on the existing
`gh-pages` branch. Other specifications and the upstream `main` publishing
workflow are unchanged.

## Maintaining the specification

See [here](https://github.com/opencomputeproject/ocp-spec-tools/blob/main/README.md#tips-and-tricks)
for guidance on maintaining the specification.
