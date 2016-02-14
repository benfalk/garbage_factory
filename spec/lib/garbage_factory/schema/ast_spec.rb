describe GarbageFactory::Schema::AST do
  let(:source)   { double }
  let(:data)     { GFFixtures.get_fixture 'flight' }
  let(:instance) { described_class.new(data, source) }

  describe '#attributes' do
    subject { instance.attributes }
    its(:count) { is_expected.to eq 4 }
  end
end
