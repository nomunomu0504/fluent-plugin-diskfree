# fluent-plugin-diskfree, a plugin for [Fluentd](http://fluentd.org)

![Testing Rubocop](https://github.com/nomunomu0504/fluent-plugin-diskfree/actions/workflows/rubocop.yml/badge.svg)

## What is this

**fluent-plugin-diskfree** is a [fluentd](http://fluentd.org "fluentd") input plugin for getting disk usage information.

## Requirements

| fluent-plugin-diskfree | fluentd | ruby |
|------------------------|---------|------|
| >= 0.1.0 | >= v1.3, < v2.0 | >= 2.6.6 |

## How to Install

Adding the line to install from Gemfile:

    gem 'fluent-plugin-diskfree'

execute command `gem install`:

    $ gem install fluent-plugin-diskfree

[td-agent](https://docs.fluentd.org/installation/install-by-rpm#what-is-td-agent) has its own Ruby ecosystem.
If you have installed td-agent, you would use `gem` command included with td-agent.

    $ sudo /path/to/fluent/ruby/bin/gem isntall fluent-plugin-diskfree

## Usage

    <source>
        @type diskfree
        option -k                # linux df command option
        refresh_interval 5       # execute refresh interval in seconds
        mount_path /             # path to check disk usage
        trim_percent true        # trim percent from result
        replace_separator true   # replace separator of result mount_path to '_'
        tag_prefix diskfree      # tag prefix
    </>

## Configuration

name | type | description
-----|------|------
option | string | linux df command option
refresh_interval | integer | execute refresh interval in seconds
mounted_path | string | path to check disk usage
trim_percent | bool | trim percent from result
replace_separator | bool | replace separator of result mount_path to '_'
tag_prefix | string | tag prefix

## Legal Notification

### Copyright

Copyright (c) 2021 h.nomura

### License

The gem is available as open source under the terms of the MIT License.

## Code of Conduct

Everyone interacting in the Fluent::Plugin::DiskFree project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nomunomu0504/fluent-plugin-diskfree/blob/master/CODE_OF_CONDUCT.md).
