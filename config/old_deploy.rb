# config valid only for current version of Capistrano
lock '3.4.0'

puts "toto"
set :user, "deployer"
set :deploy_user, "deployer"
set :use_sudo, true

set :application, 'ws-dss'
set :repo_url, 'git@github.com:sudakov/ws-dss.git'
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

application = 'ws-dss'
set :rvm_type, :user
set :rvm_ruby_version, '2.3.3'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :deploy_to, '/var/www/apps/ws-dss'

namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      puts capture("pgrep -f 'workers' | xargs kill -USR1") 
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :initctl, :restart, :workers
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'

namespace :foreman do
  desc 'Start server'
  task :start do
    on roles(:all) do
      sudo "start #{application}"
    end
  end

  desc 'Stop server'
  task :stop do
    on roles(:all) do
      sudo "stop #{application}"
    end
  end

  desc 'Restart server'
  task :restart do
    on roles(:all) do
      sudo "restart #{application}"
    end
  end

  desc 'Server status'
  task :status do
    on roles(:all) do
      execute "initctl list | grep #{application}"
    end
  end
end

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  
  desc 'Setup'
  task :setup do
    on roles(:all) do
      #execute "mkdir  #{shared_path}/config/"
      #execute "mkdir  /var/www/apps/#{application}/run/"
      #execute "mkdir  /var/www/apps/#{application}/log/"
      #execute "mkdir  /var/www/apps/#{application}/socket/"
      #execute "mkdir #{shared_path}/system"
      sudo "ln -s /var/log/upstart /var/www/log/upstart"

      #upload!('shared/database.yml', "#{shared_path}/config/database.yml")
      
      #upload!('shared/Procfile', "#{shared_path}/Procfile")


      #upload!('shared/nginx.conf', "#{shared_path}/nginx.conf")
      sudo 'stop nginx'
      #sudo "rm -f /usr/local/nginx/conf/nginx.conf"
      #sudo "ln -s #{shared_path}/nginx.conf /usr/local/nginx/conf/nginx.conf"
      sudo 'start nginx'

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end



    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      #execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      #execute "ln -s #{shared_path}/Procfile #{release_path}/Procfile"
      #execute "ln -s #{shared_path}/system #{release_path}/public/system"
    end
  end

  desc 'Foreman init'
  task :foreman_init do
    on roles(:all) do
      foreman_temp = "/var/www/tmp/foreman"
      execute  "mkdir -p #{foreman_temp}"
      # Создаем папку current для того, чтобы foreman создавал upstart файлы с правильными путями
      execute "ln -s releases/20150814145239 #{current_path}"

      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec foreman export upstart #{foreman_temp} -a #{application} -u deployer -l /var/www/apps/#{application}/log -d #{current_path}"
      end
      sudo "mv #{foreman_temp}/* /etc/init/"
      sudo "rm -r #{foreman_temp}"
    end
  end


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "restart #{application}"
    end
  end

#  after :finishing, 'deploy:cleanup'
#  after :finishing, 'deploy:restart'

#  after :updating, 'deploy:symlink'

#  after :setup, 'deploy:foreman_init'

#  after :foreman_init, 'foreman:start'

#  before :foreman_init, 'rvm:hook'

  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'
end

