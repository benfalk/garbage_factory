require 'ostruct'

module GarbageFactory
  class Schema::Attribute
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def title
    end

    def description
    end

    def default
    end

    def format
    end

    def type
    end
  end
end
