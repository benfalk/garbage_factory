module GarbageFactory
  class Schema
    attr_reader :source

    def initialize(source: {})
      @source = create_source(source)
    end

    private

    def create_source(source)
      Source.new(source)
    end
  end
end

require 'garbage_factory/schema/source'
