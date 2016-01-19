require "serverspec"

set :backend, :exec

describe "ruby::default" do
  describe ppa("brightbox/ruby-ng") do
    it { is_expected.to exist }
    it { is_expected.to be_enabled }
  end

  describe ppa("ondrej/mysql-5.7") do
    it { is_expected.to exist }
    it { is_expected.to be_enabled }
  end

  ["postgresql-client postgresql-client-common ruby2.2-dev ruby2.2"].each do |pkg|
    describe package(pkg) do
      it { is_expected.to be_installed }
    end
  end

  describe package("bundler") do
    it { is_expected.to be_installed.by("gem") }
  end

  describe package("rake") do
    it { is_expected.to be_installed.by("gem") }
  end

  describe file("/etc/gemrc") do
    it { is_expected.to exist }
    its(:content) { is_expected.to contain "update: \"--no-ri --no-rdoc\"" }
  end
end
