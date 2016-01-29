require File.expand_path('../../lib/cumulus', __FILE__)
require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'pry'

TOKEN = 'dbac7b7bfe68'
URL = 'https://api-cumulus.com'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { match_requests_on: [:method] }
end
