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

This document adopts the Composite EAT mechanism defined in
[`draft-sun-rats-composite-eat-00`](https://datatracker.ietf.org/doc/html/draft-sun-rats-composite-eat-00)
and applies OCP constraints for platform inventory attestation. It uses a
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
path/to/ocp-spec-tools/docker-run.sh --html spec.html spec.ocp
```

## Maintaining the specification

See [here](https://github.com/opencomputeproject/ocp-spec-tools/blob/main/README.md#tips-and-tricks)
for guidance on maintaining the specification.
