describe 'Enriching Complex Models' do
  let(:schema) { GFFixtures.get_fixture('flight') }

  class DinkleBerg
    include GarbageFactory.model(GFFixtures.get_fixture('flight'), at: '#/definitions/location_details')

    def to_s
      [gate_number, airport, time].join("\n")
    end
  end

  let(:flight_class) do
    flight = schema

    Class.new.instance_eval do
      include GarbageFactory.model flight, override: { '#/definitions/location_details' => DinkleBerg }
    end
  end

  let(:params) do
    {
      origin_details: {
        gate_number: '10',
        airport: 'FWA',
        time: '07:10'
      },
      destination_details: {
        gate_number: '38',
        airport: 'DFW',
        time: '09:20'
      }
    }
  end

  let(:instance) { flight_class.new(params) }

  it 'should have have the added method from the given class' do
    expect(instance.origin_details.to_s).to eq "10\nFWA\n07:10"
  end

  it 'should have have the added method from the given class' do
    expect(instance.destination_details.to_s).to eq "38\nDFW\n09:20"
  end
end
