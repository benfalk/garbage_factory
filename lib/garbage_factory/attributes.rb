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

    attr_reader :schema, :target, :overrides

    def initialize(schema: {}, at: '#/', override: {})
      @schema = schema
      @overrides = override
      @target = resolve_dependencies('$ref' => at)
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
      @properties ||= target_properties
                      .merge(additional_properties('anyOf'))
                      .merge(additional_properties('allOf'))
    end

    def additional_properties(collection_key)
      (target[collection_key] || {})
        .map(&method(:resolve_dependencies))
        .map { |additional_schema| additional_schema['properties'] }
        .compact
        .each_with_object({}) { |schema, props| props.merge! schema }
    end

    def resolve_dependencies(given_schema)
      return given_schema unless given_schema['$ref'].is_a? String
      return given_schema unless given_schema['$ref'][0, 2] == '#/'
      return given_schema if override?(given_schema)
      _, *segments = given_schema['$ref'].split('/')
      segments.reduce(schema) { |tree, branch| tree[branch] || {} }
    end

    def target_properties
      (target['properties'] || {})
        .map { |key, prop| [key, resolve_dependencies(prop)] }
        .to_h
    end

    def type_for(property)
      return override_for(property) if override?(property)
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

    def override_for(property)
      overrides[property['$ref']]
    end

    def override?(property)
      overrides.keys.include? property['$ref']
    end
  end
end
