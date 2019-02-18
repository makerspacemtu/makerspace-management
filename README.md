# Makerspace Management App

This is a simple app to assist in [The Alley](http://makerspace.mtu.edu) Makerspace.
It is designed to handle maker and coach (staff volunteers) check in/out and
trainings.

## Local Setup

1. Clone the repo: `git clone git@github.com:makerspacemtu/makerspace-management.git`
1. Install dependencies: `bundle install`
1. Setup the database: `rake db:migrate`
1. Setup the seeds: `rake db:seed`
1. Start the server `rails s` or `foreman start -p 3000`
1. Open in your browser: [localhost:3000](http://localhost:3000)

## Users

There are four user types, `Developer`, `Admin`, `Staff` and `Member`.
- Admins and Developers have global access to everything within the system. They can create and
edit users, check in/out any user, add trainings, change user types, etc.  Admins currently
go to tech, and Developers are legacy Admins.
- Staff have the ability to login and edit their own account information as
well as add trainings to any user. These are coaches in the space.
- Members are only user entities, they cannot login. These are makers in the space.

## Trainings

Admins can create training entities, these are the official trainings available
in the space. Both Admins and Staff can associate (or add) these trainings to any
individual user.

## Contributing

1. Follow the **Local Setup** above and get the app running locally.
1. Create a branch and open a pull request.
1. Add tests/specs that tests your additions.
1. After it's reviewed, merge your pull request.
