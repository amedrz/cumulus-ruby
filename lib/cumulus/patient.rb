module Cumulus
  class Patient
    PARAMETERS = {
      'id' => 'id',
      'first_name' => 'nombre',
      'middle_name' => 'apellido',
      'last_name' => 'apellidoSegundo',
      'telephone' => 'telefono',
      'telephone2' => 'telefonoAlt',
      'email' => 'correo',
      'born_at' => 'fechaNacimiento',
      'gender' => 'sexo',
      'curp' => 'curp',
      'street' => 'calle',
      'city' => 'ciudad',
      'state' => 'estado',
      'country' => 'pais',
      'zipcode' => 'codigoPostal'
    }

    PARAMETERS.keys.each { |k| attr_accessor k }

    def initialize(client, parameters={})
      @client = client
      parameters_handler.set(parameters)
    end

    def create(parameters={})
      parameters_handler.set(parameters)
      client.request(:post, '/pacientes', parameters_handler.for_request)
    end

    def update(parameters={})
      parameters_handler.set(parameters)
      client.request(:put, "/pacientes/#{curp}", parameters_handler.for_request)
    end

    def fetch(curp)
      client.request(:get, "/pacientes/#{curp}")
    end

    def search(curp, query)
      client.request(:post, "/pacientes/#{curp}/busqueda", { query: query })
    end

    private

    def client
      @client
    end

    def parameters_handler
      @parameters ||= Cumulus::Utils::ParametersHandler.new(PARAMETERS, self)
    end
  end
end
