module Thermostat
  class Builder
    attr_reader :config

    class << self
      def build config
        new(config).build
      end
    end

    def initialize config
      @config = config
    end

    def build

    end

    def status

    end
  end
end