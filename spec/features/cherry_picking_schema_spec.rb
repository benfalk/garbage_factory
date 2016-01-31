describe 'Cherry Picking from Schemas' do
  let(:schema) { GFFixtures.get_fixture('flight') }
  let(:klass) do
    flight = schema

    Class.new.instance_eval do
      include GarbageFactory.model(flight, at: '#/definitions/location_details')
    end
  end

  subject { klass.new.attributes }

  its(:keys) { is_expected.to include(:gate_number) }
  its(:keys) { is_expected.to include(:time) }
  its(:keys) { is_expected.to include(:airport) }
  its(:keys) { is_expected.to include(:country) }
  its(:keys) { is_expected.to include(:city) }
end
