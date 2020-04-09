# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

recipe = Recipe.create(title: "Ratatouille", duration: 30 * 60, description: "Ein geschmorter Gemüseeintopf, der gut zu Fleisch gegessen werden kann.")
image = Rails.root.join('test', 'fixtures', 'files', 'ratatouille.jpg')
recipe.image.attach(io: File.open(image), filename: 'ratatouille.jpg')

recipe = Recipe.create(title: "Spaghetti Bolognese", duration: 4 * 60 * 60, description: "Der Klassiker unter den italienischen Nudelgerichten.")
image = Rails.root.join('test', 'fixtures', 'files', 'bolognese.jpg')
recipe.image.attach(io: File.open(image), filename: 'bolognese.jpg')

Recipe.create(title: "Zitronensorbet", duration: 6 * 60 * 60, description: "Ein zartes Eisgericht, das viel Vorbereitungszeit benötigt.")
