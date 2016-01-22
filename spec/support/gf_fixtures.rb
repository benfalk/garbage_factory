require 'yaml'
require 'pathname'

module GFFixtures
  module_function

  def get_fixture(name)
    @fixtures ||= {}
    @fixtures[name] ||= YAML.load_file Pathname.new("#{__dir__}/../fixtures/#{name}.yml")
    @fixtures[name].dup
  end
end
