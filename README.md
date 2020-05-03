# README v1

1. Install RubyMine: Use student account to register for free
2. Install ruby (use 2.6.5): https://stackify.com/install-ruby-on-your-mac-everything-you-need-to-get-going/
3. Install rails: https://gorails.com/setup/osx/10.15-catalina
4. Install postgresql with `brew install postgresql` (I had to do this before `bundle install`)
5. run: `bundle install` into the command line. should install all the gems
6. Complete installation of postgres: https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-macos
7. create user with `createuser -P -d opia_dev`
8. setup database by running: `rake db:setup`
9. setup environment variables
10. To start rails server run `rails server`. 
