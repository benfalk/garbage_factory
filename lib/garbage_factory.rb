require 'virtus'
require 'yaml'
require 'json'
require 'open-uri'
require 'garbage_factory/version'
require 'garbage_factory/attributes'

module GarbageFactory
  module_function

  def model(schema, at: '#/', override: {})
    resolved_schema = resolve_schema(schema)
    Module.new.instance_eval do
      include Virtus.module

      Attributes.new(schema: resolved_schema, at: at, override: override).each do |attr|
        attribute(*attr)
      end

      self
    end
  end

  def resolve_schema(schema)
    return schema unless schema.is_a? String
    data = open(schema).read
    return YAML.load data if schema =~ /(.yml|.yaml)$/
    return JSON.parse data if schema =~ /.json$/
  end
end
