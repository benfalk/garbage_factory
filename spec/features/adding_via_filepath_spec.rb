describe 'Adding Schemas via File Path' do
  let(:klass) do
    file = filepath

    Class.new.instance_eval do
      include GarbageFactory.model(file)
    end
  end
  subject { klass.new }

  context 'For a YAML Schema File' do
    let(:filepath) { GFFixtures.fixture_filepath('widget') }

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

  context 'For a JSON Schema File' do
    let(:filepath) { GFFixtures.fixture_filepath('fire') }

    it 'should let you set and get "color"' do
      subject.color = 'red'
      expect(subject.color).to eq 'red'
    end

    it 'should let you set and get "temp"' do
      subject.temp = 212.0
      expect(subject.temp).to eq 212.0
    end

    it 'should let you set and get "duration"' do
      subject.duration = 13.4
      expect(subject.duration).to eq 13.4
    end
  end
end
