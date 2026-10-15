/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib

/-!
# Petersen's theorem on perfect matchings in cubic graphs

For a finite simple graph that is 3-regular (`IsRegularOfDegree 3`) and has no bridge (no edge
of the graph is a bridge, `IsBridge`):

* `PetersenMatching.exists_isPerfectMatching`: **Petersen (1891).** The graph has a perfect
  matching.
* `PetersenMatching.exists_isPerfectMatching_mem`: moreover, every edge lies in some perfect
  matching.

Both follow from Tutte's theorem (Mathlib's `SimpleGraph.tutte`) by counting the edges leaving the
odd components.

The Mathlib definitions used in these statements are reproduced verbatim, with file and line at the
pinned Mathlib revision, in `MATHLIB_DEFINITIONS.md` at the root of this repository.
-/

@[expose] public section

open SimpleGraph

namespace PetersenMatching

variable {V : Type*}

/-- **Petersen's theorem (1891).** A finite bridgeless cubic graph has a perfect matching. -/
theorem exists_isPerfectMatching [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj]
    (h3 : G.IsRegularOfDegree 3) (hb : ∀ e ∈ G.edgeSet, ¬ G.IsBridge e) :
    ∃ M : G.Subgraph, M.IsPerfectMatching := by
  sorry

/-- In a finite bridgeless cubic graph every edge lies in some perfect matching. -/
theorem exists_isPerfectMatching_mem [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj]
    (h3 : G.IsRegularOfDegree 3) (hb : ∀ e ∈ G.edgeSet, ¬ G.IsBridge e) :
    ∀ e ∈ G.edgeSet, ∃ M : G.Subgraph, M.IsPerfectMatching ∧ e ∈ M.edgeSet := by
  sorry

end PetersenMatching
