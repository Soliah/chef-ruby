[![Circle CI](https://circleci.com/gh/Soliah/chef-ruby.svg?style=svg)](https://circleci.com/gh/Soliah/chef-ruby)

# cookbook-ruby

Cookbook to install the latest Ruby from the [Brightbox PPA](https://launchpad.net/~brightbox/+archive/ruby-ng).

## Requirements

Only tested on Ubuntu 14.04, but should work on earlier versions.

## Attributes

### ruby::default

Key                         | Type   | Description
:---------------------------|--------|----------------------------------------------------------
`["ruby"]["version"]`       | String | Version of Ruby to be installed. Defaults to `ruby2.2`
`["ruby"]["experimental"]`  | String | Whether to use Brightbox's experimental Ruby PPA. Defaults to `false`
`["ruby"]["gems"]`          | Array  | Array of gems to install. Defaults to `["bundler", "rake"]`
`["ruby"]["gemrc"]`         | Hash   | YAML contents of `/etc/gemrc`. Defaults to `{ backtrace: false, benchmark: false, update_sources: true, bulk_threshold: 1000, verbose: true, install: "--no-ri --no-rdoc", update: "--no-ri --no-rdoc" }`
`["ruby"]["dependencies"]`  | Bool   | Dependencies required by Ruby and certain gems. Refer to [attributes.rb](https://github.com/Soliah/chef-ruby/tree/master/attributes/default.rb) for defaults
`["ruby"]["postgresql_ppa"]`| Bool   | Whether to add the official PostgreSQL PPA. Defaults to `false`
`["ruby"]["mysql_ppa"]`     | Bool   | Whether to add [Ondřej Surý's](https://launchpad.net/~ondrej) MySQL PPA. Defaults to `false`
`["ruby"]["mysql_version"]` | String | Version of the MySQL PPA to add. Defaults to `"5.7"`

## Usage

Just include `ruby` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[ruby]"
  ]
}
```
