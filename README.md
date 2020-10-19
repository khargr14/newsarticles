commands: $
1- bundle install
2- rake db:create(if db not setup)
3- rake db:migrate
4- rake db:seed

run local server: bundle exec rackup -p 3000
