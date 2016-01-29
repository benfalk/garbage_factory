require 'ostruct'

module GarbageFactory
  class Attributes
    include Enumerable

    CASTS = {
      'string' => String,
      'integer' => Integer,
      'boolean' => Axiom::Types::Boolean,
      'number' => Float,
      'null' => NilClass,
      'array' => Array
    }.freeze

    attr_reader :schema

    def initialize(schema: {})
      @schema = schema
    end

    def each(&block)
      attributes.each(&block)
    end

    private

    def attributes
      @attributes ||= properties.map do |attr, property|
        [attr.to_sym, type_for(property), options_for(property)].compact
      end
    end

    def properties
      @properties ||= schema_properties
                      .merge(additional_properties('anyOf'))
                      .merge(additional_properties('allOf'))
    end

    def additional_properties(collection_key)
      (schema[collection_key] || {})
        .map(&method(:resolve_dependencies))
        .map { |additional_schema| additional_schema['properties'] }
        .compact
        .each_with_object({}) { |schema, props| props.merge! schema }
    end

    def resolve_dependencies(given_schema)
      return given_schema unless given_schema['$ref'].is_a? String
      return given_schema unless given_schema['$ref'][0, 2] == '#/'
      _, *segments = given_schema['$ref'].split('/')
      segments.reduce(schema) { |tree, branch| tree[branch] || {} }
    end

    def schema_properties
      (schema['properties'] || {})
        .map { |key, prop| [key, resolve_dependencies(prop)] }
        .to_h
    end

    def type_for(property)
      return CASTS[property['type']] unless property['type'] == 'object'
      Class.new.instance_eval do
        include GarbageFactory.model(property)

        self
      end
    end

    def options_for(property)
      return { default: {} } if property['type'] == 'object'
      return { default: property['default'] } unless property['default'].nil?
    end
  end
end
