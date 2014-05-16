#
# Cookbook Name:: ruby
# Recipe:: default
#
# Author:: Christopher Chow (<chris@chowie.net>)
#
# Copyright 2014, Christopher Chow
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
  uri          "http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu"
  distribution node["lsb"]["codename"]
  components   ["main"]
  keyserver    "keyserver.ubuntu.com"
  key          "C3173AA6"
  action       :add
  notifies     :run, "execute[apt-get update]", :immediately
end

apt_repository "mysql-5.6" do
  uri          "http://ppa.launchpad.net/ondrej/mysql-5.6/ubuntu"
  distribution node["lsb"]["codename"]
  components   ["main"]
  keyserver    "keyserver.ubuntu.com"
  key          "E5267A6C"
  action       :add
  notifies     :run, "execute[apt-get update]", :immediately
end

%w(git vim zlib1g-dev libssl-dev libreadline6-dev libyaml-dev libpq-dev postgresql-client-9.3 libmysqlclient-dev build-essential).each do |pkg|
  apt_package pkg do
    action :install
  end
end

[node[:ruby][:version], "#{node[:ruby][:version]}-dev"].each do |pkg|
  apt_package pkg do
    action :upgrade
  end
end

cookbook_file "/etc/gemrc" do
  action :create_if_missing
  source "gemrc"
  mode   "0644"
end

["bundler", "rake", "rubygems-bundler"].each do |gem|
  gem_package gem do
    action :upgrade
  end
end

node["ruby"]["gems"].each do |gem|
  gem_package gem do
    action :upgrade
  end
end

# Regenerate the binstubs for rubygems-bundler.
execute "gem regenerate_binstubs" do
  action :nothing
  subscribes :run, resources("gem_package[rubygems-bundler]")
end
