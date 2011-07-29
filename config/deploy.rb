set :user, 'm4shell'  # Your dreamhost account's username
set :domain, 'www.x.xn--ycee.net'  # Dreamhost servername where your account is located 
set :project, 'testing'  # Your application as its called in the repository
set :application, 'www.x.xn--ycee.net'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:m4ry/testing.git"  # Your clone URL
set :scm, "git"
set :user, "m4ry"  # The server's user for deploys
set :scm_passphrase, "$?$!g3tM0N3Y!"  # The deploy user's password



# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false
# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end