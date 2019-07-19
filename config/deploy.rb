# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"
server '139.59.143.213', port: 22, roles: [:web, :app, :db], primary: true

set :application, "magazin"
set :deploy_via, :remote_cache
set :repo_url, "git@github.com:jealrock/magazin.git"
set :git_enable_submodules, 1
set :keep_releases, 3
set :use_sudo, true
set :pty, true

## Linked Files & Directories (Default None):
set :linked_files, %w{config/master.key .env.development config/database.yml config/credentials.yml.enc config/puma.rb}
set :linked_dirs,  %w{public/uploads tmp/cache}

set :yarn_flags, '--production --silent --no-progress'

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Restart Puma HTTP server'
  task :restart_puma do
    on roles(:app), in: :sequence, wait: 5 do
      execute :systemctl, '--user', 'restart', 'puma'
    end
  end

  desc 'Restart Sidekiq background job processing process'
  task :restart_sidekiq do
    on roles(:app), in: :sequence, wait: 5 do
      execute :systemctl, '--user', 'restart', 'sidekiq'
    end
  end

  before :starting,  :check_revision
  after  :finishing, :cleanup
  after  :finishing, :restart_puma
  after  :finishing, :restart_sidekiq
end

