# frozen_string_literal: true

require_relative "doinmotors/version"
require "f1sales_custom/source"
require "f1sales_custom/parser"
require "f1sales_helpers"

module Doinmotors
  class Error < StandardError; end
  class F1SalesCustom::Email::Source
    def self.all
      [
        {
          email_id: 'website',
          name: 'Website'
        }
      ]
    end
  end
  class F1SalesCustom::Email::Parser
    def parse
      parsed_email = @email.body.colons_to_hash(/(Telefone|Visualizar anúncio|Ano Fabricação\/Modelo|Nome|Dados do Veículo|Modelo|E-mail|Mensagem|Marca).*?:/, false)
      source = F1SalesCustom::Email::Source.all[0]

      {
        source: {
          name: source[:name]
        },
        customer: {
          name: parsed_email['nome'],
          phone: parsed_email['telefone'].tr('^0-9', ''),
          email: parsed_email['email']
        },
        product: "#{parsed_email['marca']} - #{parsed_email['modelo']}",
        description: '',
        message: (parsed_email['mensagem'] || '').split("\n").first
      }
    end
  end
end
