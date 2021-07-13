# frozen_string_literal: true

RSpec.describe Fluent::Plugin::DiskFree do
  include Fluent::Test::Helpers

  # Create confing.
  let(:config) do
    %(
      option -k
      refresh_interval 5
      mounted_path /
      trim_percent true
      replace_separator true
      tag_prefix diskfree
    )
  end

  # Create Test Driver to Input.
  let(:driver) { Fluent::Test::Driver::Input.new(described_class).configure(config) }
  # Pick-up driver instance.
  let(:input) { driver.instance }

  describe 'configure' do
    it 'should get option' do
      expect(input.option).to eq '-k'
    end

    it 'shound get refresh_interval' do
      expect(input.refresh_interval).to eq 5
    end

    it 'should get mounted_path' do
      expect(input.mounted_path).to eq '/'
    end

    it 'should get trim_percent' do
      expect(input.trim_percent).to eq true
    end

    it 'should get replace_separator' do
      expect(input.replace_separator).to eq true
    end

    it 'should get tag_prefix' do
      expect(input.tag_prefix).to eq 'diskfree'
    end
  end
end
