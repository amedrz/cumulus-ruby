module Cumulus
  class Pmx
    def initialize(client)
      @client = client
    end

    def companies
      client.request(:get, '/pemex/empresas')
    end

    def employees(params)
      client.request(:post, '/pemex/empleados', params)
    end

    def entitled(params)
      client.request(:post, '/pemex/derecho_habiente', params)
    end

    def patient(params)
      client.request(:post, '/pemex/paciente', params)
    end

    private
    def client
      @client
    end
  end
end
