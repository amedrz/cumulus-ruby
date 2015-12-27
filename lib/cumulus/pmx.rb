module Cumulus
  class Pmx
    def initialize(client)
      @client = client
    end

    def companies(params)
      client.request(:post, '/pemex/empresa', params)
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
