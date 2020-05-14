# Das Rezept ist Container für die eigentlichen Kochvorhaben. Neben allgemeinen
# Informationen wie einem optionalen Bild und Zutaten (dort mit Mengen)
# insbesondere aber die einzelnen Schritte des Rezepts.

class Recipe < ApplicationRecord

  # Die Zutaten sind an das Rezept gebunden und können einzeln nicht existieren,
  # sollte es also gelöscht werden, müssen die Zutaten nachziehen.
  has_many :ingridients, dependent: :destroy

  # Die Schritte sind ebenfalls eng mit dem Rezept verknüpft. Keine Schritte
  # ohne Rezept. Daher auch hier die Abhängigkeit beim Löschen.
  has_many :steps, dependent: :destroy

  # Ermöglicht das Anhängen eines Bildes, das angezeigt werden kann.
  has_one_attached :image

  # Das Rezept muss einen Titel besitzen, um überhaupt gültig zu sein. So bleibt
  # es auch noch ohne Vorbefüllung in der Administrationsoberfläche
  # identifizierbar.
  validates :title, presence: true

  # Ist eine Dauer hinterlegt, muss diese positiv sein. Hier wird die Zahl der
  # benötigten Sekunden hinterlegt, die später über einen Helper in eine gut
  # lesbare Form übersetzt werden.
  validates :duration, numericality: { greater_than_or_equal_to: 0,
                                       allow_nil: true }
                                       
end
