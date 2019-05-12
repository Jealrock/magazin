# Rails Vue template

# Current Stack:
- Ruby 2.5.5
- Rails 5.2.3
- Postgres
- Puma
- Sidekiq + Sidekiq-Scheduler

# What is included:

- Rspec as Default testing framework
- Rubocop with custom configuration
- Eslint with vue/recommended and airbnb-base rules
- Procfile for Heroku Deployment
- Webpacker version 3 basic config + enabled PostCss Loader
- Docker-compose setup for local development
- Basic Vue project structure with Vuex, Vue-Router and basic services (Api and Authentification with JWT)
- Overcommit commit to run rubocop and eslint on every commit
```
gem install overcommit
overcommit --install
```

# Installation
- Clone repository
- Rename root folder according the name of the project
- Change database name `/config/database.yml`
- Rename module in `/config/application.rb`
- Create and migrate database

# TODO:
- [ ] Implement JWT Authentification on the backend (preferably 'sorcery' gem)
- [ ] Circle CI integration
- [ ] Docker configuration for Rademade Docker Swarm env
- [ ] Performance, Security auto checking tools (bullet, etc...)
- [ ] Add test coverage tools (SimpleCov) 
