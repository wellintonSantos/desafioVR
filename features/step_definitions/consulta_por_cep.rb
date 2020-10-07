Quando('ele consulta o endereço pelo {string}') do |cep|
    @cep = cep
    $response = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")
end
    
Então('deve retornar os dados do endereço') do
    uf = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]
 
    expect($response.code).to eq(200)                                               # Valida se a API retornou um HTTP Code 200
    expect($response.headers.inspect).to include("application/json; charset=utf-8") # Valida se no cabeçalho da API retornou o tipo do objeto (Application/json) e se o enconding está correto (UTF-8)

    expect($response.parsed_response['cep']).not_to eq(@cep)                        # Valida se o CEP que a APi retornou é o mesmo que foi enviado
    expect($response.parsed_response['logradouro']).not_to be_nil                   # Valida se o campo NÃO é nulo
    expect($response.parsed_response['complemento']).not_to be_nil                  # Valida se o campo NÃO é nulo
    expect($response.parsed_response['bairro']).not_to be_nil                       # Valida se o campo NÃO é nulo
    expect($response.parsed_response['localidade']).not_to be_nil                   # Valida se o campo NÃO é nulo
    expect(uf).to include($response.parsed_response['uf'])                          # Valida se o UF retornado está dentro do Array de Ufs possíveis
    expect($response.parsed_response['ibge']).not_to be_nil                         # Valida se o campo NÃO é nulo
    expect($response.parsed_response['gia']).not_to be_nil                          # Valida se o campo NÃO é nulo
    expect($response.parsed_response['ddd']).not_to be_nil                          # Valida se o campo NÃO é nulo
    expect($response.parsed_response['siafi']).not_to be_nil                        # Valida se o campo NÃO é nulo

    log("IBGE code: #{$response.parsed_response['ibge']}")                          # Loga para cada CEP consultado o valor do campo IBGE (como solicitado no desafio)
end

Quando('ele consulta o endereço pelo {string} inválido') do |cep|
    @cep = cep
    $response = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")
end
    
Então('deve retornar mensagem de erro') do
    expect($response.code).to eq(200)                                               # Valida se a API retornou um HTTP Code 200
    expect($response.headers.inspect).to include("application/json; charset=utf-8") # Valida se no cabeçalho da API retornou o tipo do objeto (Application/json) e se o enconding está correto (UTF-8)

    expect($response.parsed_response['erro']).to be(true)                           # Valida se no json de retorno tem a chave "erro" com o valor true
end

Quando('ele consulta o endereço pelo {string} com formatação errada') do |cep|
    @cep = cep
    $response = HTTParty.get("https://viacep.com.br/ws/#{cep}/json/")
end
    
Então('deve retornar um HTTP code 400') do
    expect($response.code).to eq(400)                                               # Valida se a API retornou um HTTP Code 200
    expect($response.headers.inspect).to include("text/html; charset=utf-8")        # Valida se no cabeçalho da API retornou o tipo do objeto (text/HTML) e se o enconding está correto (UTF-8)
end