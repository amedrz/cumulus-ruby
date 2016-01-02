require 'spec_helper'

RSpec.describe Cumulus::Client do
  let(:client) { Cumulus::Client.new(token: TOKEN, url: URL) }

  describe '#request' do
    it 'makes requests', vcr: { cassette_name: 'root' } do
      response = client.request(:get, '/')
      expect(response).to have_key('routes')
    end
  end
end
