require "spec_helper"

describe "ruby::default" do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it "includes apt recipe" do
    expect(chef_run).to include_recipe("apt")
  end

  describe "ppas" do
    it "adds the brightbox ruby ppa" do
      expect(chef_run).to add_apt_repository("brightbox-ruby-ng")
    end

    context "experimental is true" do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.set["ruby"]["experimental"] = true
        end.converge(described_recipe)
      end

      it "adds the brightbox experimental ruby ppa" do
        expect(chef_run).to add_apt_repository("brightbox-ruby-ng").with(uri: "ppa:brightbox/ruby-ng-experimental")
      end
    end

    it "installs dependencies" do
      chef_run.node["ruby"]["dependencies"].each do |pkg|
        expect(chef_run).to install_apt_package(pkg)
      end
    end

    it "installs ruby and ruby-dev packages" do
      expect(chef_run).to install_apt_package("ruby2.2")
      expect(chef_run).to install_apt_package("ruby2.2-dev")
    end

    it "installs default gems" do
      chef_run.node["ruby"]["gems"].each do |gem|
        expect(chef_run).to install_gem_package(gem)
      end
    end

    it "creates gemrc" do
      expect(chef_run).to create_file_if_missing("/etc/gemrc")
    end

    context "postgres_dev_headers is true" do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.set["ruby"]["postgresql_dev_headers"] = true
        end.converge(described_recipe)
      end

      it "adds the postgresql ppa" do
        expect(chef_run).to add_apt_repository("postgresql")
      end
    end

    context "mysql_dev_headers is true" do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.set["ruby"]["mysql_dev_headers"] = true
          node.set["ruby"]["mysql_dev_headers_version"] = "5.5"
        end.converge(described_recipe)
      end

      it "adds the mysql ppa" do
        expect(chef_run).to add_apt_repository("mysql").with(uri: "ppa:ondrej/mysql-5.5")
      end
    end
  end
end
