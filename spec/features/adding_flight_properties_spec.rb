describe 'Adding Flight Properties from a Compound Schema' do
  let(:schema) { GFFixtures.get_fixture('flight') }
  let(:klass) do
    flight = schema

    Class.new.instance_eval do
      include GarbageFactory.model(flight)
    end
  end

  describe 'Initializing with variables' do
    let(:params) do
      {
        airline_company: 'American Airlines',
        aircraft_model: {
          max_distance: 840,
          max_passengers: 112
        },
        origin_details: {
          gate_number: 'A21',
          time: '1016-01-19 12:22 GMT',
          airport: 'FWA',
          country: 'USA',
          city: 'Fort Wayne'
        },
        destination_details: {
          gate_number: 'B18',
          time: '1016-01-19 15:22 GMT',
          airport: 'SF',
          country: 'USA',
          city: 'San Fran'
        }
      }
    end
    let(:instance) { klass.new(params) }
    subject { instance }
    its(:airline_company) { is_expected.to eq 'American Airlines' }

    describe 'the compound "aircraft_model" object' do
      subject { instance.aircraft_model }
      its(:max_distance) { is_expected.to eq 840 }
      its(:max_passengers) { is_expected.to eq 112 }
    end

    describe 'the compound "origin_details" object' do
      subject { instance.origin_details }
      its(:gate_number) { is_expected.to eq 'A21' }
      its(:time) { is_expected.to eq '1016-01-19 12:22 GMT' }
      its(:airport) { is_expected.to eq 'FWA' }
      its(:country) { is_expected.to eq 'USA' }
      its(:city) { is_expected.to eq 'Fort Wayne' }
    end

    describe 'the compound "destination_details" object' do
      subject { instance.destination_details }
      its(:gate_number) { is_expected.to eq 'B18' }
      its(:time) { is_expected.to eq '1016-01-19 15:22 GMT' }
      its(:airport) { is_expected.to eq 'SF' }
      its(:country) { is_expected.to eq 'USA' }
      its(:city) { is_expected.to eq 'San Fran' }
    end

    describe 'Getter & Setter methods' do
      subject { klass.new }
      # TODO OpenStruct doesn't work with this
    end
  end
end
