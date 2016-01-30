require 'yaml'
require 'pathname'

module GFFixtures
  module_function

  def get_fixture(name)
    @fixtures ||= {}
    @fixtures[name] ||= YAML.load_file fixture_filepath(name)
    @fixtures[name].dup
  end

  def fixture_filepath(name)
    %w(yml json)
      .map { |ext| Pathname.new("#{__dir__}/../fixtures/#{name}.#{ext}") }
      .find(&:file?)
      .to_s
  end
end
