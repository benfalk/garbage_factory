describe GarbageFactory::Schema do
  let(:source_file) { GFFixtures.fixture_filepath 'flight' }
  let(:instance) { described_class.new(source: scource_file) }
  let(:source_double) { double(:source_double) }

  before do
    allow(instance).to receive(:create_source)
      .with(source_file)
      .and_return(source_double)
  end
end
