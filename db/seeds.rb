# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.where(
  email: "admin@example.com"
).first_or_create(
  password: "password",
  first_name: "Bob",
  last_name: "Smith",
  member_since: Time.now,
  user_type: "Admin"
)

staff = User.where(
  email: "staff@example.com"
).first_or_create(
  password: "password",
  first_name: "Jill",
  last_name: "Doe",
  member_since: Time.now,
  user_type: "Staff"
)

member = User.where(
  email: "member@example.com"
).first_or_create(
  password: "password",
  first_name: "Jack",
  last_name: "William",
  member_since: Time.now,
  user_type: "Member"
)
