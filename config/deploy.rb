# config valid only for current version of Capistrano

lock '3.3.5'

set :application, 'gstt-rails'
set :repo_url, 'git@github.com:agamble/gstt-rails.git'

set :deploy_to, "/home/deployer/gstt-rails"

set :pty, true
set :format, :pretty

set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :rvm_ruby_string, :local
set :rvm_autolibs_flag, "read-only"

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
