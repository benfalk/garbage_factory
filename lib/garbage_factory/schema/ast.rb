module GarbageFactory
  class Schema::AST
    attr_reader :data, :source

    def initialize(data, source)
      @data = data
      @source = source
    end
  end
end
