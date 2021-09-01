require 'ostruct'
require 'byebug'
require "f1sales_custom/parser"
require "f1sales_custom/source"

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when is about used vechicle' do
    let(:email){
      email = OpenStruct.new
      email.to = [email: 'website@liberte.f1sales.net']
      email.subject = 'SEMINOVOS - TESTANDO LEAD SITE'
      email.body = "Proposta Recebida .\n[image: Doin Motors - Shopping The Blue] <https://www.doinmotors.com.br>\nProposta Recebida\nOlá!\n\nTem nova proposta para o Porsche Macan!\n\nDados do Cliente\n\nNome: Teste Lead Site DOIN\n\nE-mail: teste@lead.com\n\nTelefone/Celular: /(13)13131-3131\n\nDados do Veículo\n\nMarca: Porsche\n\nModelo: Macan\n\nAno Fabricação/Modelo: 2019/2019\n\nCombustível: Gasolina\n\nMensagem: Agora vai funcionar direitinho...\nVisualizar anúncio\n<https://doinmotors.com.br/carros/porsche/macan-2-0-turbo-237-252cv/2019/86505>\n(13)3327-8001 | (13)3232-1021 | website@doinmotors.f1sales.net | Avenida\nSenador Feijó, 686, Bairro Vila Mathias, CEP 11015504 | Santos - São Paulo\n.\n2021 - Doin Motors - Shopping The Blue <https://www.doinmotors.com.br> -\nTodos os direitos reservados."

      email
    }

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains lead website a source name' do
      expect(parsed_email[:source][:name]).to eq('Website')
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Teste Lead Site DOIN')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('13131313131')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('teste@lead.com')
    end

    it 'contains product' do
      expect(parsed_email[:product]).to eq('Porsche - Macan')
    end

    it 'contains message' do
      expect(parsed_email[:message]).to eq('Agora vai funcionar direitinho...')
    end
  end
end
