require_relative '../spec_helper'

describe "base:docker_spec" do
  describe service('docker') do
    it { should be_enabled }
  end

  describe "kernel cgroup settings" do
    let(:docker_info_output) { command('sudo docker info').stderr }

    it "should support cgroup memory limits" do
      expect(docker_info_output).to_not include("WARNING: No memory limit support")
    end

    it "should support cgroup swap limits" do
      expect(docker_info_output).to_not include("WARNING: No swap limit support")
    end
  end
end
