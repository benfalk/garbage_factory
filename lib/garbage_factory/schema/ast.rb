require 'ostruct'
require 'garbage_factory/schema/attribute'

module GarbageFactory
  class Schema::AST
    attr_reader :data, :source

    def initialize(data, source)
      @data = OpenStruct.new(data)
      @source = source
    end

    def attributes
      @attributes ||= properties
    end

    private

    def properties
      data.properties || {}
    end
  end
end
