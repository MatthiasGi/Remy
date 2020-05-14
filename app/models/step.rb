# Einzelner Schritt, der ein Rezept ausmacht.

class Step < ApplicationRecord

  # Ein Schritt ist an ein Rezept gebunden, zu dem er zwingend gehört.
  belongs_to :recipe

  # Jeder Schritt braucht eine Nummer, die lediglich zu Sortierungszwecken
  # genutzt wird.
  validates :number, presence: true

  # Beschreibungstext für den aktuellen Schritt. Dieser ist nötig, da er
  # zentraler Bestandteil des Schritts ist.
  validates :description, presence: true
  
end
