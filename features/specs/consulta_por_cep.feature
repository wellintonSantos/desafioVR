#language: pt

Funcionalidade: Validar dados de endereço
    Como usuário da API de viaCep
    Leandro Zanuz gostaria de realizar uma busca de endereço por CEP
    Para ter acesso aos dados de endereço

    Esquema do Cenário: Consulta endereço usando CEP válido
        Quando ele consulta o endereço pelo "<CEP>"
        Então deve retornar os dados do endereço
        Exemplos:
        |   CEP    |
        | 01001000 |
        | 04553900 |
        | 01310200 |
        | 20531590 |
        | 13500313 |
        | 95150000 |
    
    Esquema do Cenário: Consulta endereço usando CEP inválido
        Quando ele consulta o endereço pelo "<CEP>" inválido
        Então deve retornar mensagem de erro
        Exemplos:
        |   CEP    |
        | 12345678 |
        | 87654321 |
        | 00000000 |
    
    Esquema do Cenário: Consulta endereço usando CEP com formatação errada
        Quando ele consulta o endereço pelo "<CEP>" com formatação errada
        Então deve retornar um HTTP code 400
        Exemplos:
        |   CEP    |
        | 1234567  |
        | 1234-150 |
    