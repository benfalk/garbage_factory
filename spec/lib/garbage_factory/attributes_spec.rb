describe GarbageFactory::Attributes do
  let(:schema) { GFFixtures.get_fixture('person') }
  let(:instance) { described_class.new(schema: schema) }

  describe '#to_a' do
    subject { instance.to_a }

    context 'when loaded with simple person schema' do
      it { is_expected.to include([:first_name, String]) }
      it { is_expected.to include([:last_name, String]) }
      it { is_expected.to include([:age, Integer]) }
    end

    context 'when loaded with a more complex widget schema' do
      let(:schema) { GFFixtures.get_fixture('widget') }

      it { is_expected.to include([:model_number, String]) }
      it { is_expected.to include([:serial_number, String]) }
      it { is_expected.to include([:vetted, Axiom::Types::Boolean]) }
      it { is_expected.to include([:recalled, Axiom::Types::Boolean]) }
      it { is_expected.to include([:msrp, Integer]) }
      it { is_expected.to include([:rejection_rate, Float]) }
    end
  end
end
