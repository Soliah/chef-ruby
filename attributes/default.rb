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

default["ruby"]["version"] = "ruby2.2"
default["ruby"]["experimental"] = false
default["ruby"]["gems"] = {
  "bundler" => "1.16.0",
  "rake" => "12.3.1"
}
default["ruby"]["gemrc"] = {
  backtrace: false,
  benchmark: false,
  update_sources: true,
  bulk_threshold: 1000,
  verbose: true,
  install: "--no-ri --no-rdoc",
  update: "--no-ri --no-rdoc"
}

default["ruby"]["postgresql_ppa"] = false
default["ruby"]["postgresql_version"] = "9.4"
default["ruby"]["mysql_ppa"] = false
default["ruby"]["mysql_version"] = "5.7"

default["ruby"]["dependencies"] = %w(
  autoconf
  ca-certificates
  g++
  git
  gcc
  make
  patch
  bison
  build-essential
  libssl-dev
  libyaml-dev
  libreadline6-dev
  zlib1g-dev
  libncurses5-dev
  libffi-dev
  libgdbm3
  libgdbm-dev
  libc6-dev
  libgeos-dev
)
