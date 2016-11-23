require_relative '../spec_helper'

describe "base:td-agent_spec" do
  describe package('td-agent') do
    it { should be_installed }
  end

  describe('persistent journald') do
    describe service('systemd-journald') do
      it { should be_enabled }
      it { should be_running }
    end

    describe command('sudo find /var/log/journal -type f | wc -l') do
      it "should be be greater than 0" do
        expect(Integer(subject.stdout.strip, 10)).to be > 0
      end
      its(:stderr) { should be_empty }
    end

    describe command('groups td-agent') do
      it "should contain systemd-journal" do
        expect(subject.stdout).to include("systemd-journal")
      end
    end

    describe "journal permissions" do
      permissions_list = command("getfacl /var/log/journal").stdout

      it "should be set correctly" do
        expect(permissions_list).to include("mask::r-x")
        expect(permissions_list).to include("group:systemd-journal:r-x")
      end
    end
  end

  describe('services') do
    describe service('td-agent') do
      it { should be_enabled }
      it { should be_running }
    end
  end

  describe('plugins') do
    describe command('sudo td-agent-gem list | grep fluent-plugin') do
      let(:plugins) { %w(fluent-plugin-cloudwatch-logs fluent-plugin-systemd) }

      it "should have all the installed plugins" do
        installed_plugins = subject.stdout

        plugins.each do |plugin|
          expect(installed_plugins).to include(plugin)
        end
      end
    end
  end

  describe('td-agent syntax') do
    let(:dry_run_output) { command('sudo td-agent --dry-run').stdout }

    it "should not have warnings or errors" do
      %w(warn error).each do |level|
        expect(dry_run_output).to_not include("[#{level}]")
      end
    end

    it "should have the unified match pattern" do
      expect(dry_run_output).to include("adding match pattern=\"**.unified.**\" type=\"copy\"")
    end

    it "should have the local unified file log" do
      expect(dry_run_output).to include("path /var/log/td-agent/unified")
    end

    it "should have the cloudwatch log type" do
      expect(dry_run_output).to include("type cloudwatch_logs")
    end
  end
end
