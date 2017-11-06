#
# Cookbook Name:: ruby
# Recipe:: default
#
# Author:: Kinesis Pty Ltd <devs@kinesis.org>
#
# Copyright 2016, Kinesis Pty Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"

apt_repository "brightbox-ruby-ng" do
  uri          "ppa:brightbox/ruby-ng#{"-experimental" if node["ruby"]["experimental"]}"
  distribution node["lsb"]["codename"]
  notifies     :run, "execute[apt-get update]", :immediately
end

if node["ruby"]["mysql_ppa"]
  apt_repository "mysql" do
    uri          "ppa:ondrej/mysql-#{node["ruby"]["mysql_version"]}"
    distribution node["lsb"]["codename"]
    notifies     :run, "execute[apt-get update]", :immediately
  end
end

if node["ruby"]["postgresql_ppa"]
  apt_repository "postgresql" do
    uri          "http://apt.postgresql.org/pub/repos/apt"
    distribution "#{node["lsb"]["codename"]}-pgdg"
    components   ["main"]
    key          "https://www.postgresql.org/media/keys/ACCC4CF8.asc"
    notifies     :run, "execute[apt-get update]", :immediately
  end

  package "libpq-dev" do
    action :install
  end
end

node["ruby"]["dependencies"].each do |pkg|
  package pkg do
    action :install
  end
end

apt_package "postgresql-client-#{node["ruby"]["postgresql_version"]}" do
  action :install
  only_if { node["ruby"]["postgresql_ppa"] }
end

[node[:ruby][:version], "#{node[:ruby][:version]}-dev"].each do |pkg|
  package pkg do
    action :install
  end
end

file "/etc/gemrc" do
  action :create_if_missing
  content node["ruby"]["gemrc"].to_h.to_yaml
  mode   "0644"
end

execute "update rubygems" do
  action :run
  command "gem update --system 2.6.14"
end

node["ruby"]["gems"].each do |gem|
  gem_package gem do
    action :install
  end
end
