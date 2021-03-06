{-# OPTIONS --without-K #-}

open import lib.Basics
open import lib.types.Span
open import lib.types.Pointed
open import lib.types.Pushout
open import lib.types.PushoutFlattening
open import lib.types.Unit
open import lib.types.Paths

-- Suspension is defined as a particular case of pushout

module lib.types.Suspension where

module _ {i} (A : Type i) where

  suspension-span : Span
  suspension-span = span Unit Unit A (λ _ → tt) (λ _ → tt)

  Suspension : Type i
  Suspension = Pushout suspension-span

  north : Suspension
  north = left tt

  south : Suspension
  south = right tt

  merid : A → north == south
  merid x = glue x

  module SuspensionElim {j} {P : Suspension → Type j} (n : P north)
    (s : P south) (p : (x : A) → n == s [ P ↓ merid x ])
    = PushoutElim (λ _ → n) (λ _ → s) p

  open SuspensionElim public using () renaming (f to Suspension-elim)

  module SuspensionRec {j} {C : Type j} (n s : C) (p : A → n == s)
    = PushoutRec {d = suspension-span} (λ _ → n) (λ _ → s) p

  module SuspensionRecType {j} (n s : Type j) (p : A → n ≃ s)
    = PushoutRecType {d = suspension-span} (λ _ → n) (λ _ → s) p

suspension-ptd-span : ∀ {i} → Ptd i → Ptd-Span
suspension-ptd-span X =
  ptd-span Ptd-Unit Ptd-Unit X (ptd-cst {X = X}) (ptd-cst {X = X})

Ptd-Susp : ∀ {i} → Ptd i → Ptd i
Ptd-Susp (A , _) = ∙[ Suspension A , north A ]

module _ {i j} where

  module SuspFmap {A : Type i} {B : Type j} (f : A → B) =
    SuspensionRec A (north B) (south B) (merid B ∘ f)

  susp-fmap : {A : Type i} {B : Type j} (f : A → B)
    → (Suspension A → Suspension B)
  susp-fmap = SuspFmap.f

  ptd-susp-fmap : {X : Ptd i} {Y : Ptd j} (f : fst (X ∙→ Y))
    → fst (Ptd-Susp X ∙→ Ptd-Susp Y)
  ptd-susp-fmap (f , fpt) = (susp-fmap f , idp)

module _ {i} where

  susp-fmap-idf : (A : Type i) → ∀ a → susp-fmap (idf A) a == a
  susp-fmap-idf A = Suspension-elim _ idp idp $ λ a →
    ↓-='-in (ap-idf (merid _ a) ∙ ! (SuspFmap.glue-β (idf A) a))

  ptd-susp-fmap-idf : (X : Ptd i)
    → ptd-susp-fmap (ptd-idf X) == ptd-idf (Ptd-Susp X)
  ptd-susp-fmap-idf X = ptd-λ= (susp-fmap-idf (fst X)) idp

module _ {i j k} where

  susp-fmap-∘ : {A : Type i} {B : Type j} {C : Type k} (g : B → C) (f : A → B)
    (σ : Suspension A) → susp-fmap (g ∘ f) σ == susp-fmap g (susp-fmap f σ)
  susp-fmap-∘ g f = Suspension-elim _
    idp
    idp
    (λ a → ↓-='-in $
      ap-∘ (susp-fmap g) (susp-fmap f) (merid _ a)
      ∙ ap (ap (susp-fmap g)) (SuspFmap.glue-β f a)
      ∙ SuspFmap.glue-β g (f a)
      ∙ ! (SuspFmap.glue-β (g ∘ f) a))

  ptd-susp-fmap-∘ : {X : Ptd i} {Y : Ptd j} {Z : Ptd k}
    (g : fst (Y ∙→ Z)) (f : fst (X ∙→ Y))
    → ptd-susp-fmap (g ∘ptd f) == ptd-susp-fmap g ∘ptd ptd-susp-fmap f
  ptd-susp-fmap-∘ g f = ptd-λ= (susp-fmap-∘ (fst g) (fst f)) idp

