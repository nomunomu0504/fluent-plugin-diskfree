# fluent-plugin-diskfree, a plugin for [Fluentd](http://fluentd.org)

[![GitHub-Actions](https://github.com/nomunomu0504/fluent-plugin-diskfree/actions/workflows/rubocop.yml/badge.svg?branch=master)](https://github.com/nomunomu0504/fluent-plugin-diskfree/actions/workflows/rubocop.yml)

# What is this

**fluent-plugin-diskfree** is a [fluentd](http://fluentd.org "fluentd") input plugin for getting disk usage information.

## Requirements

| fluent-plugin-diskfree | fluentd | ruby |
|:----------------------:|:-------:|:----:|
| >= 0.1.0 | >= v1.3, < v2.0 | >= 2.6.6 |

# How to Install

Adding the line to install from Gemfile:

    gem 'fluent-plugin-diskfree'

execute command `gem install`:

    $ gem install fluent-plugin-diskfree

[td-agent](https://docs.fluentd.org/installation/install-by-rpm#what-is-td-agent) has its own Ruby ecosystem.
If you have installed td-agent, you would use `gem` command included with td-agent.

    $ sudo /path/to/fluent/ruby/bin/gem isntall fluent-plugin-diskfree

# Usage

    <source>
        @type diskfree
        option -k                # linux df command option
        refresh_interval 5       # execute refresh interval in seconds
        mounted_path /           # path to check disk usage
        trim_percent true        # trim percent from result
        replace_separator true   # replace separator of result mount_path to '_'
        tag_prefix diskfree      # tag prefix
    </source>

# Configuration

name | type | default value | description
-----|------|-----|------
option | string | -k | linux df command option
refresh_interval | integer | 5 | execute refresh interval in seconds
mounted_path | string | / | path to check disk usage
trim_percent | bool | true | trim percent from result
replace_separator | bool | true | replace separator of result mount_path to '_'
tag_prefix | string | diskfree | tag prefix

# How To Test

They can testing by using [rspec](https://github.com/rspec/rspec-core "rspec") and [fluent-plugin-testing](https://github.com/fluent/fluent-plugin-testing "fluent-plugin-testing").

## RSpec Test
    $ bundle exec rspec

## Ruby Linter Test(rubocop)
    $ bundle exec rubocop

## Ruby Linter Test(rubocop - auto correct)
    $ bundle exec rubocop --auto-correct

# Operation Verification

They can using Dockerfile and docker-compose.yml to verify the operation of the plugin.

    $ docker-compose run fluentd ash

In the fluentd container, execute command below:

    / $ fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugin

※ These files are hot-loaded since fluent.conf and the plugin folder are volume mounted by docker-compose.

# Legal Notification

## Copyright

Copyright (c) 2021 h.nomura

## License

The gem is available as open source under the terms of the MIT License.

## Code of Conduct

Everyone interacting in the Fluent::Plugin::DiskFree project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nomunomu0504/fluent-plugin-diskfree/blob/master/CODE_OF_CONDUCT.md).
