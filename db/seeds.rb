# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Planet.create(
  name: "Sun",
  description: "The basic inner force motivating everything we do.",
  swe_id: 0
)

Planet.create(
  name: "Moon",
  description: "How you react instinctively to all experiences.",
  swe_id: 1
)

Planet.create(
  name: "Mercury",
  description: "The urge to establish contact and communication with others.",
  swe_id: 2
)

Planet.create(
  name: "Venus",
  description: "How you express affection, love, and sensual pleasure with others.",
  swe_id: 3
)

Planet.create(
  name: "Mars",
  description: "Your physical excitement, energy, leadership, and initiative.",
  swe_id: 4
)

Planet.create(
  name: "Jupiter",
  description: "Inner faith, confidence, abundance, and opportunity.",
  swe_id: 5
)

Planet.create(
  name: "Saturn",
  description: "Challenge, constriction, restriction, and inhibition.",
  swe_id: 6
)

Planet.create(
  name: "Uranus",
  description: "Originality, innovation, discovery, and progression.",
  swe_id: 7
)

Planet.create(
  name: "Neptune",
  description: "Inspiration, imagination, spirituality, and psychic intuition.",
  swe_id: 8
)

Planet.create(
  name: "Pluto",
  description: "Destruction, renewal, endings, and new beginnings.",
  swe_id: 9
)