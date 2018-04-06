# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

#set :application, "my_app_name"
#set :repo_url, "git@example.com:me/my_repo.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure


set :application, 'sampleApp'
set :repo_url, 'git@github.com:vijay-maropost/sampleApp.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/ubuntu/sampleApp'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :airbrussh.
set :format, :pretty

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is [] for example files that you dont want to send to git. like application.yml
set :linked_files, fetch(:linked_files, []).push()


namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      execute 'sudo service nginx restart'
    end
  end

  after :publishing, :restart
end

task :migrate do
  on roles(:app) do
    within release_path do
      with rack_env: fetch(:rack_env) do
        execute :rake, "db:migrate"
      end
    end
  end
end

after 'deploy', 'migrate'

# set :application, 'sampleApp' #change this to the name of your app
# set :repo_url, 'git@github.com:vijay-maropost/sampleApp.git'
# set :deploy_to, '/home/ubuntu/sampleApp'
# set :use_sudo, true
# set :branch, 'master' #or whichever branch you want to use
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
