require 'spec_helper'

RSpec.describe Cumulus::Client do
  let(:client) { Cumulus::Client.new(token: TOKEN) }

  it 'returns api endpoint url' do
    expect(Cumulus::Client::API_URL).to eq('https://api-cumulus.com')
  end

  describe '#request' do
    it 'makes requests', vcr: { cassette_name: 'root' } do
      response = client.request(:get, '/')
      expect(response).to have_key('routes')
    end
  end
end
