# frozen_string_literal: true

require_relative 'diskfree/version'
require 'fluent/plugin/input'

#--------------------------------------------
# Fluentd linux Disk free command plugin
# refs: https://docs.fluentd.org/plugin-development
#--------------------------------------------
module Fluent
  module Plugin
    # Disk free command plugin class.
    class DiskFree < Input
      # Register Plugin to Fluent Input type.
      Fluent::Plugin.register_input('diskfree', self)

      # Load fluentd timer helper.
      # refs: https://docs.fluentd.org/plugin-helper-overview/api-plugin-helper-timer
      helpers :timer

      # Load fluentd event emitter helper.
      # refs: https://docs.fluentd.org/plugin-helper-overview/api-plugin-helper-event-emitter
      helpers :event_emitter

      #-------------------------------------
      # df header cols length
      # Filesystem, 1024-blocks, Used, Available, Capacity, Mounted on
      #-------------------------------------
      DF_HEADER_COLMUS_LENGTH = 6

      #-------------------------------------
      # Configuration for Diskfree Params
      #-------------------------------------
      # --block-size=1K
      config_param :option,            :string,  default: '-k'
      # 5[sec]
      config_param :refresh_interval,  :integer, default: 5
      # default is root path.
      config_param :mounted_path,      :string,  default: '/'
      # trim percent from Used
      config_param :trim_percent,      :bool,    default: true
      # replace / with _ in mounted_path
      config_param :replace_separator, :bool,    default: true
      # default nil, if exists output tag is #{tag_prefix}.#{mounted_path}
      config_param :tag_prefix,        :string,  default: 'diskfree'

      #-------------------------------------
      # Fluent plugin configuration method.
      #-------------------------------------
      def configure(conf)
        super
        # -P: use the POSIX output format
        @execute_command = "df -P #{@option} #{@mounted_path} 2> /dev/null"
      end

      #-------------------------------------
      # Fluent plugin multi worker
      #-------------------------------------
      def multi_workers_ready?
        true
      end

      #-------------------------------------
      # Fluent plugin start method.
      #-------------------------------------
      def start
        super
        timer_execute(:in_diskfree, @refresh_interval, repeat: true, &method(:run_timer))
      end

      #-------------------------------------
      # Private method
      #-------------------------------------
      private

      #-------------------------------
      # Main method
      #-------------------------------
      def diskfree
        # Get df output. splited by line.
        result = `#{@execute_command}`.split(/\R/)
        # Remove df output header.
        result.shift
        result.map do |line|
          # split by space.
          data_list = line.split(/\s+/)
          # check header colmus length.
          log.error("Invalid df output format. #{line}") unless data_list.length == DF_HEADER_COLMUS_LENGTH
          # Calclate disk free percent.
          denominator = data_list[1].to_f * 100
          used_percent = (data_list[2] / denominator).floor(2)
          available_percent = (data_list[3] / denominator).floor(2)
          # output data.
          disk_info = {
            'mounted_path' => replace_separator(data_list[0]),
            'disksize' => data_list[1].to_i,
            'used' => data_list[2].to_i,
            'used_percent' => @trim_percent ? used_percent : "#{used_percent}%",
            'available' => data_list[3].to_i,
            'available_percent' => @trim_percent ? available_percent : "#{available_percent}%",
            'capacity' => data_list[4].to_i
          }
          disk_info
        end
      end

      #-------------------------------------
      # Replace / with _ in mounted_path.
      #-------------------------------------
      def replace_separator(path)
        @replace_separator ? path.gsub(%r{/}, '_') : path
      end

      #-------------------------------------
      # Callback method for timer.
      #-------------------------------------
      def run_timer
        diskfree.each do |result|
          router.emit("#{@tag_prefix}.#{@mounted_path}", Fluent::Engine.now, result)
        end
      end
    end
  end
end
