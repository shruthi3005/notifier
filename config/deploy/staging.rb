server '35.154.154.88', port: 22, roles: [:web, :app, :db], primary: true

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :staging
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
set :scm,           :git
set :branch,        "5-push-notifications"
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 5

