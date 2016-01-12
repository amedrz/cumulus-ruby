require 'spec_helper'

RSpec.describe Cumulus::Pmx do
  let(:client) { Cumulus::Client.new(token: TOKEN, url: URL) }
  let(:pmx) { Cumulus::Pmx.new(client) }

  describe '#fetch_companies' do
    it 'fetches companies list', :vcr do
      response = pmx.fetch_companies

      expect(response[0].keys).to match_array(['empresa', 'numeroEmpresa'])
    end
  end

  describe '#fetch_employees' do
    it 'fetches employees', :vcr do
      response = pmx.fetch_employees({
        'numeroEmpresa' => '10',
        'numeroEmpleado' => '123'
      })

      expect(response[0]).to have_key('nombre')
    end
  end

  describe '#fetch_entitled' do
    it 'fetches entitled person', :vcr do
      response = pmx.fetch_entitled({
        'numeroEmpresa' => '10',
        'numeroEmpleado' => '123',
        'codigoDerechoHabiente' => '0'
      })

      expect(response.keys).to match_array(['pemex', 'derechoHabiente',
        'localidad'])
    end
  end

  describe '#fetch_patient' do
    it 'fetches patient information', :vcr do
      response = pmx.fetch_patient({
        'numeroEmpresa' => '10',
        'numeroEmpleado' => '123',
        'codigoDerechoHabiente' => '0'
      })

      expect(response).to have_key('id')
    end
  end

  describe '#link_patient' do
    it 'links a patient with pemex entitlement', :vcr do
      response = pmx.link_patient('AMED123123', {
          'numeroEmpresa' => '123',
          'numeroEmpleado' => '124',
          'codigoDerechoHabiente' => '0',
          'localidad' => 'Localidad 01',
          'derechoHabiente' => false
      })

      expect(response).to have_key('id')
    end
  end
end
