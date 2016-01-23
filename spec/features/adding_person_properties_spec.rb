describe 'Adding Person Properties from a Simple Schema' do
  let(:schema) { GFFixtures.get_fixture('person') }
  let(:klass) do
    person = schema

    Class.new.instance_eval do
      include GarbageFactory.model(person)
    end
  end

  describe 'Initializing with variables' do
    subject { klass.new(first_name: 'Ben', last_name: 'Falk', age: '33') }
    its(:first_name) { is_expected.to eq 'Ben' }
    its(:last_name) { is_expected.to eq 'Falk' }
    its(:age) { is_expected.to eq 33 }
  end

  describe 'Getter & Setter methods' do
    subject { klass.new }

    it 'should let you add and get "first_name"' do
      subject.first_name = 'rofl'
      expect(subject.first_name).to eq 'rofl'
    end

    it 'should let you add and get "last_name"' do
      subject.last_name = 'copter'
      expect(subject.last_name).to eq 'copter'
    end

    it 'should let you add and get "age"' do
      subject.age = 99
      expect(subject.age).to eq 99
    end
  end
end
