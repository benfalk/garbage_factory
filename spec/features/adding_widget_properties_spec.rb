describe 'Adding Widget Properties from a Slightly More Complex Schema' do
  let(:schema) { GFFixtures.get_fixture('widget') }
  let(:klass) do
    widget = schema

    Class.new.instance_eval do
      include GarbageFactory.model(widget)
    end
  end

  describe 'Initializing with variables' do
    let(:params) do
      {
        model_number: '90210',
        vetted: true,
        recalled: false,
        serial_number: '840388-42537',
        rejection_rate: 0.05,
        msrp: 13_000
      }
    end
    subject { klass.new(params) }
    its(:model_number) { is_expected.to eq '90210' }
    its(:vetted) { is_expected.to be true }
    its(:recalled) { is_expected.to be false }
    its(:serial_number) { is_expected.to eq '840388-42537' }
    its(:rejection_rate) { is_expected.to eq 0.05 }
    its(:msrp) { is_expected.to eq 13_000 }
  end

  describe 'Getter & Setter methods' do
    subject { klass.new }

    it 'should let you set and get "model_number"' do
      subject.model_number = '77099'
      expect(subject.model_number).to eq '77099'
    end

    it 'should let you set and get "vetted"' do
      subject.vetted = false
      expect(subject.vetted).to be false
    end

    it 'should let you set and get "recalled"' do
      subject.recalled = true
      expect(subject.recalled).to be true
    end

    it 'should let you set and get "serial_number"' do
      subject.serial_number = 'T1000'
      expect(subject.serial_number).to eq 'T1000'
    end
  end
end
