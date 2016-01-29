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

    context 'when loaded with a complex compound object schema' do
      let(:schema) { GFFixtures.get_fixture('flight') }

      it { is_expected.to include([:airline_company, String]) }
      it { is_expected.to include([:aircraft_model, be_a_instance_of(Class), { default: {} }]) }
      it { is_expected.to include([:origin_details, be_a_instance_of(Class), { default: {} }]) }
      it { is_expected.to include([:destination_details, be_a_instance_of(Class), { default: {} }]) }
    end

    context 'when loaded with a schema defining defaults' do
      let(:schema) { GFFixtures.get_fixture('vehicle') }

      it { is_expected.to include([:audio_entertainment, Axiom::Types::Boolean, { default: false }]) }
      it { is_expected.to include([:requires_license, Axiom::Types::Boolean, { default: true }]) }
      it { is_expected.to include([:wheel_count, Integer, { default: 2 }]) }
    end
  end
end
