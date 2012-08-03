require 'drb'
require 'socket'

module Synack

  class Server

    DEFAULT_OPTIONS = {
      host: 'localhost',
      port: 11113
    }

    attr_reader :host, :port, :socket

    # Class methods ================================================================================

    def self.start(options={})
      options = DEFAULT_OPTIONS.merge(options)
      @host = options[:host]
      @port = options[:port].to_i
      @@server = Synack::Server.new
      puts "Synack server running. Fire at will."
      ::DRb.start_service("druby://#{@host}:#{@port}", @@server)
      ::DRb.thread.join
    end

    def self.stop
      ::DRb.stop_service
    end

    # Instance methods =============================================================================

    def say(message, passthrough = false)
      puts message
      system "/Applications/terminal-notifier.app/Contents/MacOS/terminal-notifier #{message}"
    end

  end

end
