admin = User.where(
  email: "admin@mtu.edu"
).first_or_create(
  password: "password",
  first_name: "Bob",
  last_name: "Smith",
  member_since: Time.now,
  user_type: "Admin"
)

staff = User.where(
  email: "staff@mtu.edu"
).first_or_create(
  password: "password",
  first_name: "Jill",
  last_name: "Doe",
  member_since: Time.now,
  user_type: "Staff"
)

member = User.where(
  email: "member@mtu.edu"
).first_or_create(
  password: "password",
  first_name: "Jack",
  last_name: "William",
  member_since: Time.now,
  user_type: "Member"
)
