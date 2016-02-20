# config valid only for current version of Capistrano
lock '3.4.0'

set :stage, :production
set :application, 'blog'
set :repo_url, 'git@github.com:MarconiVini/blog.git'
set :deploy_to, '/var/www/blog'
set :scm, :git
set :pty, true
set :keep_releases, 5
set :user, "mv"
set :group, "deployers"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :rvm_ruby_version, 'ruby-head@blog --create' 

server "162.243.123.35", roles: [:web, :app, :db], primary: true

set :default_env, { rvm_bin_path: '/usr/local/rvm/bin' }

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # desc "installing bundler"
  # task :install_bundler do
  #   on roles(:app) do
  #     execute 'gem install bundler'
  #   end
  # end

  # before :deploy, 'deploy:install_bundler'
end