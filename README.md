# cookbook-ruby

Cookbook to install the latest Ruby from the [Brightbox PPA](https://launchpad.net/~brightbox/+archive/ruby-ng).

## Requirements

Only tested on Ubuntu 14.04, but should work on earlier versions.

## Attributes

### ruby::default

Key                    | Type   | Description
:----------------------|--------|----------------------------------------------------------
`["ruby"]["version"]`  | String | Version of Ruby to be installed. Defaults to `ruby2.1`
`["ruby"]["gems"]`     | Array  | Array of gems to install. Defaults to `[]`

## Usage

Just include `ruby` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[ruby]"
  ]
}
```

## License

    Copyright (C) 2015 Kinesis Pty Ltd

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
