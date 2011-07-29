default_run_options[:pty] = true  

set :user, 'm4shell'  # Your dreamhost account's username
set :domain, 'x.xn--ycee.net'  # Dreamhost servername where your account is located 
set :project, 'testing'  # Your application as its called in the repository
set :application, 'x.xn--ycee.net'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

set :repository, "git@github.com:m4ry/testing.git"  # Your clone URL
set :scm, "git"


ssh_options[:auth_methods]

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :use_sudo, false
# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end