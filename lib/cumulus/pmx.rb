module Cumulus
  class Pmx
    def initialize(client)
      @client = client
    end

    def fetch_companies
      client.request(:get, '/pemex/empresas')
    end

    def fetch_employees(params)
      client.request(:post, '/pemex/empleados', params)
    end

    def fetch_entitled(params)
      client.request(:post, '/pemex/derecho_habiente', params)
    end

    def fetch_patient(params)
      client.request(:post, '/pemex/paciente', params)
    end

    def fetch_patient_by_curp(curp)
      client.request(:get, "/pacientes/#{curp}/pemex")
    end

    def link_patient(curp, params)
      client.request(:post, "/pacientes/#{curp}/pemex", params)
    end

    private

    def client
      @client
    end
  end
end
