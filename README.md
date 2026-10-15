# Petersen's theorem in Lean 4

Author and maintainer: **Juan Pablo Traverso Gianini**. Licence: Apache-2.0 (see `LICENSE`).

This repository formalizes, for a finite simple graph that is 3-regular and has no bridge:

1. **Petersen's theorem (1891).** The graph has a perfect matching
   (`PetersenMatching.exists_isPerfectMatching`).
2. **Every edge lies in some perfect matching** (`PetersenMatching.exists_isPerfectMatching_mem`).

The notions are Mathlib's:
- `SimpleGraph.IsRegularOfDegree 3`;
- `SimpleGraph.IsBridge`, where "no bridge" means that no edge of the graph is a bridge;
- `SimpleGraph.Subgraph.IsPerfectMatching`.

## Files

- [`Challenge.lean`](Challenge.lean): the audited statements. It imports only Mathlib.
- [`Solution.lean`](Solution.lean) and [`PetersenLib/Petersen.lean`](PetersenLib/Petersen.lean):
  the proofs.
- [`comparator.json`](comparator.json): the theorems that are compared.
- [`MATHLIB_DEFINITIONS.md`](MATHLIB_DEFINITIONS.md): verbatim copies of the Mathlib definitions
  used.
- [`formalization.yaml`](formalization.yaml): provenance, sources and process.

## How the proof goes

Both statements follow from Tutte's theorem (Mathlib's `SimpleGraph.tutte`).

**Key count.** Let `C` be a vertex set of odd size.
- The number of edges leaving `C` is `3|C|` minus twice the number of edges inside `C`, so it is
  odd.
- It is not 1, because a single leaving edge would be a bridge.
- So at least three edges leave `C`.

**Petersen's theorem.**
1. Each odd component of `G − S` sends at least three edges to `S`.
2. `S` receives at most `3|S|` edges.
3. So `G − S` has at most `|S|` odd components, and Tutte's condition holds.

**An edge `uv` in a perfect matching.**
1. Run the same count with `S ∪ {u, v}`. Together with a parity argument, it shows that `G` with
   `u` and `v` removed satisfies Tutte's condition.
2. Add the edge `uv` to that perfect matching.

## Sources

* J. Petersen, *Die Theorie der regulären graphs*, Acta Math. 15 (1891) 193–220,
  doi:10.1007/BF02392606.
* W. T. Tutte, *The factorization of linear graphs*, J. London Math. Soc. 22 (1947) 107–111,
  doi:10.1112/jlms/s1-22.2.107. This is the source of the theorem used, which is already in
  Mathlib.

## Authorship and use of AI

The author chose the result. The statements and proof plan were written with Claude in Claude
Code. Harmonic's Aristotle produced the proofs, which were audited and rebuilt locally. Lean
checks everything mechanically. See `formalization.yaml`.

## Building

Lean `v4.35.0-rc3`, Mathlib `c55e6e786f49471c72fbddbec5415808896aec1e`:

```bash
lake exe cache get
lake build
```
