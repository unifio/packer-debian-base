require 'rake'
require 'rspec/core/rake_task'
require 'bundler/setup'

require 'dotenv'
Dotenv.load

require 'covalence/spec_tasks'
require 'covalence/environment_tasks'
require 'covalence/packer_tasks'

ENV['ANSIBLE_ROOT_DIR'] ||= File.expand_path("ansible/", __dir__)
ENV['ANSIBLE_PLAYS_DIR'] ||= File.join(ENV['ANSIBLE_ROOT_DIR'], "plays")
ENV['ANSIBLE_ROLE_PATHS'] ||= Dir.glob("#{File.join(ENV['ANSIBLE_ROOT_DIR'], "roles")}/{external,internal}/*").join(",")
