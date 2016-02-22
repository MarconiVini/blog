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
#puma
set :puma_state, "#{shared_path}/pids/puma.state"
set :puma_pid, "#{shared_path}/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/sockets/puma.sock"
set :puma_default_control_app, "unix://#{shared_path}/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 6]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, false
set :nginx_use_ssl, false

server "162.243.123.35", roles: [:web, :app, :db], primary: true

set :default_env, { 
  rvm_bin_path: '/usr/local/rvm/bin',
  RAILS_ENV: 'production'
}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  
  after :deploy, 'puma:stop'
  after :deploy, 'puma:start'
end
