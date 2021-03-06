{-# OPTIONS --without-K #-}

open import lib.Basics
open import lib.types.Group
open import lib.types.Unit
open import lib.groups.Homomorphisms
open import lib.groups.Lift

module lib.groups.Unit where

Unit-group-structure : GroupStructure Unit
Unit-group-structure = record
  { ident = unit
  ; inv = λ _ → unit
  ; comp = λ _ _ → unit
  ; unitl = λ _ → idp
  ; unitr = λ _ → idp
  ; assoc = λ _ _ _ → idp
  ; invr = λ _ → idp
  ; invl = λ _ → idp
  }

Unit-Group : Group lzero
Unit-Group = group _ Unit-is-set Unit-group-structure

LiftUnit-Group : ∀ {i} → Group i
LiftUnit-Group = Lift-Group Unit-Group

0G = LiftUnit-Group

contr-iso-LiftUnit : ∀ {i} (G : Group i) → is-contr (Group.El G) → G == 0G
contr-iso-LiftUnit G pA = group-iso
  (group-hom (λ _ → lift unit) idp (λ _ _ → idp))
  (snd (contr-equiv-LiftUnit pA))

0G-hom-out-level : ∀ {i j} {G : Group i}
  → is-contr (GroupHom (0G {j}) G)
0G-hom-out-level {G = G} =
  (cst-hom ,
   λ φ → hom= _ _ (λ= (λ {(lift unit) → ! (GroupHom.pres-ident φ)})))

0G-hom-in-level : ∀ {i j} {G : Group i}
  → is-contr (GroupHom G (0G {j}))
0G-hom-in-level {G = G} =
  (cst-hom , λ φ → hom= _ _ (λ= (λ _ → idp)))
