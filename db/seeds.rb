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
(1...5).each do |day|
  (15...21).each do |time|
    time2 = time + 1
    Signup.create(
      signup_day: day,
      signup_start: "#{time}:00:00",
      signup_qty: 3,
      created_at: Time.now,
      updated_at: Time.now
    )
  end
end
