[ ![Codeship Status for MarcvanMelle/Poke-Connector](https://app.codeship.com/projects/96ea1a30-76ab-0134-3da1-4269843b54e0/status?branch=master)](https://app.codeship.com/projects/179634)

# Poke-Connector Read Me

### Ruby Version 2.3.1

### Heroku Requirements

Poke-Connector requires a google account and password for config variables.
It will also require a Redis Server to maintain Sidekiq and Sidetiq background jobs.

### Database
Poke-Connector uses a postgreSQL databse. To build the database first create and migrate. Running the seed through `rails db:seed` takes some patience, as the pokeapi.co api times-out after about 200 Pokemon, and so will require several iterations, manually setting up the start point on the iterator in the seeds.rb.

Also, attempting to seed in production is unstable, so it is recommended to `heroku pg:push <development-database> DATABASE_URL` in order to get the Pokemon table into production.

### Tests
Currently all tests are run using rspec and capybara. Running `rake` will execute all tests.
