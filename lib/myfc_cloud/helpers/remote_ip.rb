# encoding: utf-8
module MyfcCloud # :nodoc:
  module Helpers # :nodoc:
    class RemoteIp
      attr_reader :ip_address

      def initialize(fetch=false)
        @ip_address = nil
        fetch! if fetch
      end

      # http://what-is-my-ip.net/
      # http://ifconfig.me/
      # http://ifconfig.me/ip
      # http://wtfismyip.com/
      # http://wtfismyip.com/?json
      # http://wtfismyip.com/?text
      # http://wtfismyip.com/json
      # http://wtfismyip.com/text
      # TOSPEC
      def fetch!
        # TODO
        @ip_address = 'foo'
      end

    end
  end
end
