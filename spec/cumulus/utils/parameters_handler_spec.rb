require 'spec_helper'

RSpec.describe Cumulus::Utils::ParametersHandler do
  let(:parameters) do
    {
      'first_name' => 'nombre',
      'middle_name' => 'apellido',
      'last_name' => 'apellidoSegundo',
    }
  end

  let(:object) do
    Struct.new(:first_name, :middle_name, :last_name)
  end

  let(:object_instance) do
    object.new('John', 'Doe', 'Foo')
  end

  let(:handler) do
    Cumulus::Utils::ParametersHandler.new(parameters, object_instance)
  end

  describe '#for_request' do
    it 'returns correct parameters' do
      parameters = handler.for_request

      expect(parameters).to(
        include('nombre' => 'John', 'apellido' => 'Doe',
          'apellidoSegundo' => 'Foo')
      )
    end
  end

  describe '#cleanup' do
    it 'returns correct parameters' do
      parameters = handler.cleanup(first_name: 'John', last_name: 'Doe',
        foo: 'bar')

      expect(parameters).to(
        include('first_name' => 'John', 'last_name' => 'Doe')
      )
    end
  end

  describe '#set' do
    it 'returns correct parameters' do
      parameters = handler.set(first_name: 'Elvis', last_name: 'Presley')

      expect(object_instance.first_name).to eq('Elvis')
      expect(object_instance.last_name).to eq('Presley')
    end
  end
end
