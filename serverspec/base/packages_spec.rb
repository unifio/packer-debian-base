require_relative '../spec_helper'

describe "base:package_spec" do
  @apt_packages = %w(
    chrony
    curl
    dbus
    dnsutils
    jq
    libffi-dev
    libssl-dev
    python-dev
    python-pip
    td-agent
    wget
  )

  @pip_packages = %w(
    awscli
    jinja2
    paramiko
    pycrypto
    pyyaml
    setuptools
  )


  @apt_packages.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  describe command('sudo apt-get upgrade') do
    its(:stdout) { should match /0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded/ }
  end

  describe package('ansible') do
    it { should be_installed.by('pip').with_version('2.0.2.0') }
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
