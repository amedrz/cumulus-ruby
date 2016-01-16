# Cumulus Ruby Gem

A Ruby wrapper for the Cumulus API.

You should access the Cumulus API documentation in order to learn more about the
request/response parameters for each endpoint.

## Installation

```
$ gem install cumulus_ruby
```

Or if you are using Bundler, add

````
gem 'cumulus_ruby'
```

## API Usage Examples

You will need to get an access token. Once you have it, initialize the client
to make authenticated calls.

```ruby
require 'cumulus'

client = Cumulus::Client.new(token: '<redacted>', url: '<redacted>')
```

### Patients

Create a patient.

```ruby
attributes = { first_name: 'John', middle_name: 'Doe', curp: 'JDOE' }
patient = Cumulus::Patient.new(client, attributes)
patient.create
# or
patient = Patient.new(client)
patient.create(attributes)
```

Update a patient.

```ruby
patient.update(first_name: 'Mike')
```

Fetch a patient.

```ruby
patient = Cumulus::Patient.fetch(client, patient.curp)
```

Search patient info.

```ruby
patient.search(other_patient.curp, { query: 'foo' })
```

### P*mex

```ruby
pmx = Cumulus::Pmx.new(client)
```

Fetch Pemex companies

```ruby
pmx.fetch_companies
```

Fetch Pemex employees

```ruby
pmx.fetch_employees({
  'numeroEmpresa' => '123',
  'numeroEmpleado' => '123'
})
```

Fetch Pemex entitled

```ruby
pmx.fetch_entitled({
  'numeroEmpresa' => '123',
  'numeroEmpleado' => '123',
  'codigoDerechoHabiente' => '0'
})
```

Fetch patient by Pemex

```ruby
pmx.fetch_patient({
  'numeroEmpresa' => '123',
  'numeroEmpleado' => '123',
  'codigoDerechoHabiente' => '0'
})
```

Fetch patient by CURP

```ruby
pmx.fetch_patient_by_curp('SIFU123123')
```

Link patient to Pemex

```ruby
pmx.link_patient('AMED123123', {
  'numeroEmpresa' => '123',
  'numeroEmpleado' => '124',
  'codigoDerechoHabiente' => '0',
  'localidad' => 'Localidad 01',
  'derechoHabiente' => false
})
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
