require 'spec_helper'

RSpec.describe Cumulus::Pmx do
  let(:client) { Cumulus::Client.new(token: TOKEN, url: URL) }
  let(:pmx) { Cumulus::Pmx.new(client) }

  describe '#companies' do
    it 'looks for companies', :vcr do
      response = pmx.companies

      expect(response[0].keys).to match_array(['empresa', 'numeroEmpresa'])
    end
  end

  describe '#employees' do
    it 'looks for employees', :vcr do
      response = pmx.employees({ 'numeroEmpleado' => '123',
        'numeroEmpresa' => '123' })

      expect(response[0].keys).to match_array(['pemex', 'derechoHabiente',
        'localidad'])
    end
  end

  describe '#entitled' do
    it 'looks for entitlement', :vcr do
      response = pmx.entitled({ 'numeroEmpresa' => '123',
        'numeroEmpleado' => '123', 'codigoDerechoHabiente' => '0' })

      expect(response.keys).to match_array(['pemex', 'derechoHabiente',
        'localidad'])
    end
  end
end
