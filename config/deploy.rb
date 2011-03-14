require "bundler/capistrano"

set :application, "nswbus"
set :repository,  "git@github.com:mynameisrufus/nswbus.git"
set :scm, :git
set :branch, "master"

set :use_sudo, false
set :runner, user
set :domain, "203.17.62.137"
set :deploy_via, "remote_cache"
set :deploy_to, "~/www/#{application}"
set :keep_releases, 2

ssh_options[:forward_agent] = true
ssh_options[:paranoid] = false
ssh_options[:user] = 'rails'

role :web, domain
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :update_config, :roles => [:app] do
  run "cp -Rf #{shared_path}/config/* #{release_path}/config/"
end

after "deploy:update_code", :update_config
