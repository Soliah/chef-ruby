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
default["ruby"]["gems"] = ["bundler", "rake"]
default["ruby"]["gemrc"] = {
  backtrace: false,
  benchmark: false,
  update_sources: true,
  bulk_threshold: 1000,
  verbose: true,
  install: "--no-ri --no-rdoc",
  update: "--no-ri --no-rdoc"
}

default["ruby"]["dependencies"] = %w(
  autoconf
  ca-certificates
  g++
  git
  gcc
  libc6-dev
  make
  patch
  libbz2-dev
  libcurl4-openssl-dev
  libevent-dev
  libffi-dev
  libglib2.0-dev
  libncurses-dev
  libpq-dev
  libmysqlclient-dev
  libreadline-dev
  libssl-dev
  libxml2-dev
  libxslt-dev
  libyaml-dev
  zlib1g-dev
)

default["ruby"]["postgresql_ppa"] = false
default["ruby"]["mysql_ppa"] = false
default["ruby"]["mysql_version"] = "5.7"
