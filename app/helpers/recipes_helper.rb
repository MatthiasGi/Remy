module RecipesHelper

  # Gibt die Dauer eines Rezepts schön formatiert aus, also als Zeichenkette
  # der Art "H:MM:SS".
  def duration(recipe)
    dur = recipe.duration or return ""

    seconds = dur % 60
    dur = (dur - seconds) / 60
    minutes = dur % 60
    hours = (dur - minutes) / 60
    
    hours > 0 and return "%d:%02d:%02d" % [hours, minutes, seconds]
    "%d:%02d" % [minutes, seconds]
  end

end
