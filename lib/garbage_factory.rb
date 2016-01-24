require 'virtus'
require 'garbage_factory/version'
require 'garbage_factory/attributes'

module GarbageFactory
  module_function

  def model(schema)
    Module.new.instance_eval do
      include Virtus.module

      Attributes.new(schema: schema).each do |attr|
        attribute(*attr)
      end

      self
    end
  end
end
