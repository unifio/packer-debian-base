require 'json'
require_relative '../spec_helper'

describe "base:datadog_spec" do
  describe service('datadog') do
    it { should be_enabled }
    #it { should be_running }
  end

  #describe "datadog docker service" do
    #let(:docker_service) { JSON.parse(command('docker inspect datadog.service').stdout) }

    #it "should be running" do
      #expect(docker_service[0]["State"]["Status"]).to eq("running")
    #end
  #end

  describe file('/etc/dd-agent/conf.d') do
    it { should exist }
    it { should be_directory }
  end

  describe file('/etc/dd-agent/checks.d') do
    it { should exist }
    it { should be_directory }
  end
end
