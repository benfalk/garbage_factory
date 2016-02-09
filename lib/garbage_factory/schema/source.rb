require 'open-uri'
require 'pathname'
require 'uri'
require 'garbage_factory/schema/ast'

module GarbageFactory
  class Schema::Source
    attr_reader :scheme, :source

    def initialize(source, scheme: :auto)
      @source = source
      @scheme = determine_scheme(scheme)
    end

    def ast
      Schema::AST.new(to_h, self)
    end

    def to_h
      data = open(source).read
      return YAML.load data if source.to_s =~ /(.yml|.yaml)$/
      return JSON.parse data if source.to_s =~ /.json$/
    end

    private

    def determine_scheme(scheme)
      return scheme unless scheme == :auto
      return :auto if source.is_a? Hash
      return :file if filepath?
    end

    def filepath?
      path = Pathname.new(source.to_s)
      path.exist? && path.file?
    end
  end
end
