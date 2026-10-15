# Mathlib definitions used in Challenge.lean (Petersen's theorem)

Verbatim excerpts of the Mathlib definitions used by the statements in `Challenge.lean`, at the
pinned Mathlib revision `c55e6e786f49471c72fbddbec5415808896aec1e` (tag `v4.35.0-rc3`, repository
https://github.com/leanprover-community/mathlib4). Mathlib is released under the Apache-2.0
licence. Each excerpt gives the file and line at that revision; the complete source is at
`https://github.com/leanprover-community/mathlib4/blob/c55e6e786f49471c72fbddbec5415808896aec1e/<file>`.

These excerpts are provided so that the meaning of every imported notion used by the
Challenge can be audited without fetching Mathlib.

## SimpleGraph

`Mathlib/Combinatorics/SimpleGraph/Basic.lean`, line 95:

```lean
/-- A simple graph is an irreflexive symmetric relation `Adj` on a vertex type `V`.
The relation describes which pairs of vertices are adjacent.
There is exactly one edge for every pair of adjacent vertices;
see `SimpleGraph.edgeSet` for the corresponding edge set.
-/
@[ext, aesop safe constructors (rule_sets := [SimpleGraph]), wikidata Q141488]
structure SimpleGraph (V : Type u) where
  /-- The adjacency relation of a simple graph. -/
  Adj : V → V → Prop
  symm : Std.Symm Adj := by aesop_graph
  loopless : Std.Irrefl Adj := by aesop_graph
```

## SimpleGraph.Reachable

`Mathlib/Combinatorics/SimpleGraph/Connectivity/Connected.lean`, line 52:

```lean
/-- Two vertices are *reachable* if there is a walk between them.
This is equivalent to `Relation.ReflTransGen` of `G.Adj`.
See `SimpleGraph.reachable_iff_reflTransGen`. -/
def Reachable (u v : V) : Prop := Nonempty (G.Walk u v)
```

## SimpleGraph.Walk

`Mathlib/Combinatorics/SimpleGraph/Walk/Basic.lean`, line 54:

```lean
/-- A walk is a sequence of adjacent vertices.  For vertices `u v : V`,
the type `walk u v` consists of all walks starting at `u` and ending at `v`.

We say that a walk *visits* the vertices it contains.  The set of vertices a
walk visits is `SimpleGraph.Walk.support`.

See `SimpleGraph.Walk.nil'` and `SimpleGraph.Walk.cons'` for patterns that
can be useful in definitions since they make the vertices explicit. -/
inductive Walk : V → V → Type u
  | nil {u : V} : Walk u u
  | cons {u v w : V} (h : G.Adj u v) (p : Walk v w) : Walk u w
  deriving DecidableEq
```

## SimpleGraph.edgeSet

`Mathlib/Combinatorics/SimpleGraph/Basic.lean`, line 483:

```lean
/-- `G.edgeSet` is the edge set for `G`.
This is an abbreviation for `edgeSetEmbedding G` that permits dot notation. -/
abbrev edgeSet (G : SimpleGraph V) : Set (Sym2 V) := edgeSetEmbedding V G
```

## SimpleGraph.neighborFinset

`Mathlib/Combinatorics/SimpleGraph/Finite.lean`, line 169:

```lean
/-- `G.neighborFinset v` is the `Finset` version of `G.neighborSet v` in case `G` is
locally finite at `v`. -/
def neighborFinset : Finset V :=
  (G.neighborSet v).toFinset
```

## SimpleGraph.degree

`Mathlib/Combinatorics/SimpleGraph/Finite.lean`, line 242:

```lean
/-- `G.degree v` is the number of vertices adjacent to `v`. -/
def degree : ℕ := #(G.neighborFinset v)
```

## SimpleGraph.IsRegularOfDegree

`Mathlib/Combinatorics/SimpleGraph/Finite.lean`, line 390:

```lean
/-- A locally finite simple graph is regular of degree `d` if every vertex has degree `d`. -/
@[wikidata Q826467]
def IsRegularOfDegree (d : ℕ) : Prop :=
  ∀ v : V, G.degree v = d
```

## SimpleGraph.IsBridge

`Mathlib/Combinatorics/SimpleGraph/Connectivity/Connected.lean`, line 759:

```lean
/-- An edge of a graph is a *bridge* if without it, its incident vertices
are not reachable from one another. -/
def IsBridge (G : SimpleGraph V) (e : Sym2 V) : Prop :=
  Sym2.lift ⟨fun v w ↦ ¬ (G.deleteEdges {e}).Reachable v w, by simp [reachable_comm]⟩ e
```

## SimpleGraph.deleteEdges

`Mathlib/Combinatorics/SimpleGraph/DeleteEdges.lean`, line 46:

```lean
/-- Given a set of vertex pairs, remove all of the corresponding edges from the
graph's edge set, if present.

See also: `SimpleGraph.Subgraph.deleteEdges`. -/
def deleteEdges (s : Set (Sym2 V)) : SimpleGraph V := G \ fromEdgeSet s
```

## SimpleGraph.Subgraph

`Mathlib/Combinatorics/SimpleGraph/Subgraph.lean`, line 63:

```lean
/-- A subgraph of a `SimpleGraph` is a subset of vertices along with a restriction of the adjacency
relation that is symmetric and is supported by the vertex subset.  They also form a bounded lattice.

Thinking of `V → V → Prop` as `Set (V × V)`, a set of darts (i.e., half-edges), then
`Subgraph.adj_sub` is that the darts of a subgraph are a subset of the darts of `G`. -/
@[ext]
structure Subgraph {V : Type u} (G : SimpleGraph V) where
  /-- Vertices of the subgraph -/
  verts : Set V
  /-- Edges of the subgraph -/
  Adj : V → V → Prop
  adj_sub : ∀ {v w : V}, Adj v w → G.Adj v w
  edge_vert : ∀ {v w : V}, Adj v w → v ∈ verts
  symm : Std.Symm Adj := by aesop_graph
```

## SimpleGraph.Subgraph.edgeSet

`Mathlib/Combinatorics/SimpleGraph/Subgraph.lean`, line 250:

```lean
/-- The edge set of `G'` consists of a subset of edges of `G`. -/
def edgeSet (G' : Subgraph G) : Set (Sym2 V) := Sym2.fromRel G'.symm
```

## SimpleGraph.Subgraph.IsSpanning

`Mathlib/Combinatorics/SimpleGraph/Subgraph.lean`, line 156:

```lean
/-- A subgraph is called a *spanning subgraph* if it contains all the vertices of `G`. -/
def IsSpanning (G' : Subgraph G) : Prop :=
  ∀ v : V, v ∈ G'.verts
```

## SimpleGraph.Subgraph.IsMatching

`Mathlib/Combinatorics/SimpleGraph/Matching.lean`, line 67:

```lean
/--
The subgraph `M` of `G` is a matching if every vertex of `M` is incident to exactly one edge in `M`.
We say that the vertices in `M.support` are *matched* or *saturated*.
-/
def IsMatching (M : Subgraph G) : Prop := ∀ ⦃v⦄, v ∈ M.verts → ∃! w, M.Adj v w
```

## SimpleGraph.Subgraph.IsPerfectMatching

`Mathlib/Combinatorics/SimpleGraph/Matching.lean`, line 236:

```lean
/--
The subgraph `M` of `G` is a perfect matching on `G` if it's a matching and every vertex `G` is
matched.
-/
def IsPerfectMatching (M : G.Subgraph) : Prop := M.IsMatching ∧ M.IsSpanning
```

## Sym2

`Mathlib/Data/Sym/Sym2.lean`, line 100:

```lean
/-- `Sym2 α` is the symmetric square of `α`, which, in other words, is the
type of unordered pairs.

It is equivalent in a natural way to multisets of cardinality 2 (see
`Sym2.equivMultiset`).
-/
abbrev Sym2 (α : Type u) := Quot (Sym2.Rel α)
```
