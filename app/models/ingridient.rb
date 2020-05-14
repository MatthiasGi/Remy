# Eine Zutat ist einem Rezept zugeordnet und nimmt auch eine Menge auf.

class Ingridient < ApplicationRecord

  # Jede Zutat wird einem Rezept zugeordnet.
  belongs_to :recipe

  # Jede Zutat muss einen Bezeichner haben, während eine Menge optional ist.
  validates :label, presence: true
  
end
