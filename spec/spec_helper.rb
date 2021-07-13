# frozen_string_literal: true

# Load fluent test.
require 'fluent/test'

# Disabled Test::Unit Auto-Result-View execute with RSpec
Test::Unit::AutoRunner.need_auto_run = false if defined? Test::Unit::AutoRunner

# Load fluent test helpers
require 'fluent/test/helpers'

# Load fluent input test driver.
require 'fluent/test/driver/input'

# Load plugin.
require 'fluent/plugin/in_diskfree'

RSpec.configure do |config|
  # Initialize fluent test.
  config.before(:all) { Fluent::Test.setup }

  config.order = :random
end
