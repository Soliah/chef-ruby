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

  describe package("ruby2.2") do
    it { is_expected.to  be_installed }
  end

  describe package("ruby2.2-dev") do
    it { is_expected.to be_installed }
  end

  describe package("bundler") do
    it { is_expected.to be_installed.by("gem") }
  end

  describe package("rake") do
    it { is_expected.to be_installed.by("gem") }
  end
end
