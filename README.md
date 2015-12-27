# Cumulus Ruby Gem

A Ruby wrapper for the Cumulus API.

## Installation

```
$ gem install cumulus_ruby
```

## API Usage Examples

You will need to get an access token. Once you have it, initialize the client
to make authenticated further calls.

```ruby
# initializing the client
client = Cumulus::Client.new(token: 'access-token')
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
patient.fetch(other_patient.curp)
```

Search patient info.

```ruby
patient.search(other_patient.curp, { query: 'foo' })
```

### P*mex

```ruby
pmx = Cumulus::Pmx.new(client)
```

Look for companies

```ruby
pmx.companies({ 'numeroEmpleado' => '123' })
```

Look for entitlement

```ruby
pmx.entitled({ 'numeroEmpresa' => '123',
  'numeroEmpleado' => '123', 'codigoDerechoHabiente' => '0' })
```

Look for a patient

```ruby
pmx.patient({ 'numeroEmpresa' => '123',
  'numeroEmpleado' => '123', 'codigoDerechoHabiente' => '0' })
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
