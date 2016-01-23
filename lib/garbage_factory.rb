require 'garbage_factory/version'
require 'virtus'

module GarbageFactory
  module_function

  CASTS = {
    'string' => String,
    'integer' => Integer,
    'boolean' => Axiom::Types::Boolean,
    'number' => Float,
    'null' => NilClass,
    'object' => Hash,
    'array' => Array
  }.freeze

  def model(schema)
    Module.new.instance_eval do
      include Virtus.module

      schema['properties'].each do |attr, props|
        attribute attr.to_sym, CASTS[props['type']]
      end

      self
    end
  end
end
