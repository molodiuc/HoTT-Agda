Homotopy Type Theory in Agda
============================

Introduction
------------

This repository contains the development of homotopy type theory and univalent foundations in Agda.
The structure of the source code is described below.

There is also an introduction to Agda for homotopy type theorists in the `tutorial` directory
containing everything you need to know to understand the Agda code here, be sure to check it out.

Conventions
-----------

A few naming conventions:

- Theorems of the form `is-prop A` where `A` is a particular type are named `A-is-prop`, and
  similarly with `is-contr`, `is-set`, `is-equiv`, etc.
- Theorems of the form `is-prop A` where `A` is a type such that `has-something A` is inhabited are
  named `something-is-prop` (and not `has-something-is-prop`, because this would mean `is-prop
  (has-something A)`)
- Theorems about computing the h-level of something when the h-level of the composants are known are
  called `A-hlevel`. In particular you have `→-hlevel` and `pi-hlevel` for nondependent and
  dependent product and `×-hlevel` and `sigma-hlevel` for sums.
- Functions between two types `A` and `B` are sometimes called `A-to-B`
- Equivalences between two types `A` and `B` are called `A-equiv-B` or `f-equiv` if the function
  underlying the equivalence is `f`. In particular you can have

      A-to-B : A → B
      A-to-B-is-equiv : is-equiv (A-to-B)
      A-to-B-equiv : A ≃ B
      A-equiv-B : A ≃ B

Structure of the source
-----------------------

The structure of the source is roughly the following:

### Base library

- `Types` contains the definitions of the basic types (universe levels, unit, empty, dependent sums,
  natural numbers, integers, …)
- `Functions` contains basic definitions about functions (composition, identities, constant maps)
- `Paths` contains the definitions and properties of paths types and the groupoid structure of
  types, transport of something in a fibration along a path and its various reduction rules, and
  other convenient constructions and properties
- `Contractible` contains some basic properties of contractible types (not needing the notion of
  equivalence)
- `Equivalences` contains the definition of equivalences and useful properties
- `Univalence` contains the statement of the univalence axiom
- `Funext` contains the proof of function extensionality (using univalence)
- `HLevel` contains various definitions and properties about h-levels
- `FiberEquivalences` contains the proof that a map between fibrations which is an equivalence of
  total spaces is a fiberwise equivalence (depends only on `Equivalences` and above)
- `Base` exports everything above and is the file that should be imported in any file

- `Integers.Integers` contains the definition of the successor function, the proof that it’s an
  equivalence, and the proof that the type of the integers is a set

### Homotopy

The `Homotopy` directory contains homotopy-theoretic definitions and properties. More precisely
there is:

- `Homotopy.PullbackDef` contains the definition of the type that should satisfy the universal
  property of pullback with respect to every type in a fixed universe of the form `Set i`
- `Homotopy.PullbackUP` contains the definition of what it means for some type to satisfy the
  universal property of pullback inside some subcategory (parametrized by a `P : Set i → hProp i`)
- `Homotopy.PullbackIsPullback` contains a proof that what should be a pullback is indeed a
  pullback
- Similarly for `Homotopy.PushoutDef`, `Homotopy.PushoutUP` and
  `Homotopy.PushoutIsPushout`. The file `Homotopy.PushoutUP` also contains a proof that
  two pushouts of the same diagram are equivalent
- `Homotopy.ReflectiveSubCategory` contains a definition of reflective subcategories and some
  properties
- `Homotopy.TruncatedHIT` contains the proof that an HIT with special constructors that fill
  spheres can be given an elimination rule easier to work with (see `Algebra.FreeGroup` for an
  example)
- `Homotopy.TruncationHIT` contains the HIT defining the truncation, with a small hack to handle
  (hlevel 0)-truncations
- `Homotopy.Truncation` contains a nicer interface for truncation and the universal property

### Spaces

The `Spaces` directory contains definitions and properties of various spaces.

- `Spaces.Interval` contains the definition of the interval
- `Spaces.IntervalProps` contains a proof that the interval is contractible and that the interval
  implies (non-dependent) function extensionality
- `Spaces.Circle` contains the HIT definition of the circle
- `Spaces.LoopSpaceCircle` contains the proof that the based loop space of the circle is equivalent
  to the type of the integers
- `Spaces.Suspension` contains the definition of the suspension of a type (as a special case of
  pushout)
- `Spaces.Spheres` contains the definitions of spheres
- `Spaces.WedgeCircles` contains the definition of the wedge of a set of circles
- `Spaces.LoopSpaceWedgeCircles` contains the proof that it’s loop space is the free group
  (when the set of generators has decidable equality), up to the end of the flattening lemma
- `Spaces.LoopSpaceWedgeCircles2` contains the rest of the proof

### Algebra

The `Algebra` directory contains some basic algebra.

- `Algebra.Groups` contains a crappy definition of a group
- `Algebra.GroupIntegers` contains a proof that the integers form a group
- `Algebra/FreeGroup` contains the definition of the free group on a set of generators
- `Algebra/FreeGroupProps` contains properties of the free group (that it’s a set and that
  multiplying by a generator is an equivalence)
- `Algebra/F2NotCommutative` contains a proof that F2 is not commutative
- `Algebra/FreeGroupAsReducedWords` contains an equivalent definition of the free group as a set
  of reduced words, in the case where the set of generators has decidable equality

### Sets

The `Sets` repository contains properties of the category of (h)sets.

- `Sets/Quotient.agda` contains a definition of the quotient of a set by a (prop-valued)
  equivalence relation with truncated higher inductive types
- `Sets/QuotientUP.agda` proves the universal property of quotients