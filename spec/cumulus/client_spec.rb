require 'spec_helper'

RSpec.describe Cumulus::Client do
  let(:client) { Cumulus::Client.new(token: TOKEN, url: URL) }
  let(:attributes) do
    { first_name: 'Jhon', middle_name: 'Doe', curp: nil }
  end
  let(:patient) { Cumulus::Patient.new(client) }

  it 'catches HTTP 400 errors', :vcr do
    expect { patient.create(attributes) }.to raise_error(Faraday::ClientError,
      'the server responded with status 400')
  end
end
