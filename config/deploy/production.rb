server '139.59.143.213', port: 22, roles: [:web, :app, :db], primary: true
set :ssh_options, {
  verify_host_key: :never,
  forward_agent: true,
  user: "rails",
  keys: ['../../.ssh/magazin-digitalocean']
}
set :deploy_to, "/home/rails/#{fetch(:application)}"
set :user, "rails"
set :runner, "rails"
set :branch, "dev"
