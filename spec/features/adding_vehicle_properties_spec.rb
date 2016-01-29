describe 'Adding Vehicle Properties from a Schema' do
  let(:schema) { GFFixtures.get_fixture('vehicle') }
  let(:klass) do
    vehicle = schema

    Class.new.instance_eval do
      include GarbageFactory.model(vehicle)
    end
  end

  describe 'The default variables from a freshly created instance' do
    subject { klass.new }
    its(:audio_entertainment) { is_expected.to be false }
    its(:requires_license) { is_expected.to be true }
    its(:wheel_count) { is_expected.to eq 2 }
  end

  describe 'Initialized variables override the defaults' do
    let(:params) do
      {
        audio_entertainment: true,
        requires_license: false,
        wheel_count: 1
      }
    end
    subject { klass.new(params) }

    its(:audio_entertainment) { is_expected.to be true }
    its(:requires_license) { is_expected.to be false }
    its(:wheel_count) { is_expected.to eq 1 }
  end
end
