require "bundler/capistrano"

ssh_options[:user] = 'rufus'
ssh_options[:forward_agent] = true
ssh_options[:paranoid] = false

set :rails_env, "production"
set :deploy_to, "~/www/nswbus"
set :domain, "203.17.62.137"
set :application, "nswbus"
set :use_sudo, false
set :scm, :git
set :repository,  "git@github.com:mynameisrufus/nswbus.git"
set :deploy_via, "remote_cache"

set :unicorn_binary, "/usr/local/bin/unicorn"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

role :web, domain
role :app, domain
role :db, domain, :primary => true

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

task :update_config, :roles => [:app] do
  run "cp -Rf #{shared_path}/config/* #{release_path}/config/"
end

after "deploy:update_code", :update_config
