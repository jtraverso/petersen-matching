/-
Copyright (c) 2026 Juan Pablo Traverso Gianini. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Juan Pablo Traverso Gianini
-/
module

public import Mathlib
public import PetersenLib.Petersen

/-!
# Proofs of the statements in `Challenge.lean`

The theorems are proved in `PetersenLib/Petersen.lean` (namespace `PetersenTheorem`) from
Mathlib's Tutte theorem: an odd set of vertices in a bridgeless cubic graph sends an odd number,
hence at least three, of edges to the rest, so a set `S` has at most `|S|` odd components
removing it; for an edge `uv`, the same count with `S ∪ {u, v}` and a parity argument give a
perfect matching of the graph without `u`, `v`.
-/

@[expose] public section

open SimpleGraph

namespace PetersenMatching

variable {V : Type*}

/-- **Petersen's theorem (1891).** A finite bridgeless cubic graph has a perfect matching. -/
theorem exists_isPerfectMatching [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj]
    (h3 : G.IsRegularOfDegree 3) (hb : ∀ e ∈ G.edgeSet, ¬ G.IsBridge e) :
    ∃ M : G.Subgraph, M.IsPerfectMatching :=
  PetersenTheorem.exists_isPerfectMatching G h3 hb

/-- In a finite bridgeless cubic graph every edge lies in some perfect matching. -/
theorem exists_isPerfectMatching_mem [Fintype V] (G : SimpleGraph V) [DecidableRel G.Adj]
    (h3 : G.IsRegularOfDegree 3) (hb : ∀ e ∈ G.edgeSet, ¬ G.IsBridge e) :
    ∀ e ∈ G.edgeSet, ∃ M : G.Subgraph, M.IsPerfectMatching ∧ e ∈ M.edgeSet :=
  PetersenTheorem.exists_isPerfectMatching_mem G h3 hb

end PetersenMatching
