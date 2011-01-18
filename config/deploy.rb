set :application, "set your application name here"
set :repository,  "set your repository location here"

default_run_options[:pty] = true
set :repository,  "git@github.com:spacecow/referenca.git"
set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache

set :application, "referenca"
set :deploy_to, "/var/www/apps/#{application}"
set :user, "deploy"
set :admin_runner, "deploy"
  
role :app, "sao.firsec.riec.tohoku.ac.jp"
role :web, "sao.firsec.riec.tohoku.ac.jp"
role :db,  "sao.firsec.riec.tohoku.ac.jp", :primary => true



# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
