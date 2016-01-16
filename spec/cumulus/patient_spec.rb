require 'spec_helper'
require 'securerandom'

RSpec.describe Cumulus::Patient do
  let(:client) { Cumulus::Client.new(token: TOKEN, url: URL) }
  let(:attributes) do
    { first_name: 'Jhon', middle_name: 'Doe', curp: SecureRandom.hex(5) }
  end

  describe '#create' do
    context 'without attributes' do
      let(:patient) { Cumulus::Patient.new(client, attributes) }

      it 'creates a patient', :vcr do
        response = patient.create

        expect(response.keys).to match_array(['msj', 'id'])
      end
    end

    context 'with attributes' do
      let(:patient) { Cumulus::Patient.new(client) }

      it 'creates a patient', :vcr do
        response = patient.create(attributes)

        expect(response.keys).to match_array(['msj', 'id'])
      end
    end
  end

  describe '#update' do
    let(:patient) { Cumulus::Patient.new(client, attributes) }

    it 'updates a patient', vcr: { match_requests_on: [:method] } do
      patient.create

      response = patient.update(first_name: 'Mike')

      expect(patient.first_name).to eq('Mike')
      expect(response.keys).to match_array(['msj', 'id', 'url'])
    end
  end

  describe '.fetch' do
    it 'fetches a patient', vcr: { match_requests_on: [:method] } do
      response = Cumulus::Patient.fetch(client, attributes[:curp])

      expect(response).to have_key('id')
    end
  end
end
