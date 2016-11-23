require_relative '../spec_helper'

describe "base:package_spec" do
  @apt_packages = %w(
    chrony
    consul
    consul-template
    curl
    dnsutils
    envconsul
    jq
    python-pip
    python-yaml
    vault
    vault-ssh-helper
    wget
  )

  @pip_packages = %w(
    awscli
    pyyaml
    setuptools
  )


  @apt_packages.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  describe package('awscli') do
    it { should_not be_installed.by('apt') }
  end

  @pip_packages.each do |pkg|
    describe package(pkg) do
      it { should be_installed.by('pip') }
    end
  end
end
