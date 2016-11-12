require 'serverspec'
require 'net/ssh'

options = Net::SSH::Config.for(host, [])
options[:user] = ENV['TARGET_USER']
options[:keys] = ENV['TARGET_KEY']
options[:host_name] = ENV['TARGET_HOST']
options[:port] = ENV['TARGET_PORT']
options[:paranoid] = false unless ENV['SERVERSPEC_HOST_KEY_CHECKING'] =~ (/^(true|t|yes|y|1)$/i)
backend = ENV.fetch('SERVERSPEC_BACKEND', 'ssh').to_sym

set :host,         options[:host_name]
set :ssh_options,  options
set :backend,      backend
set :disable_sudo, false
set :request_pty,  true
