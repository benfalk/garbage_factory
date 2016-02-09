describe GarbageFactory::Schema::Source do
  let(:source_file) { GFFixtures.fixture_filepath 'flight' }
  let(:instance) { described_class.new(source_file) }
  subject { instance }

  its(:scheme) { is_expected.to eq(:file) }
  its(:to_h) { is_expected.to eq GFFixtures.get_fixture('flight') }
  its(:ast) { is_expected.to be_a(GarbageFactory::Schema::AST) }
end
