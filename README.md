# README

Este é um desafio por InovaMind no desenvolvimento
de uma API de citações, baseada em web crawler.

### Gerando Token de Acesso pelo Browser

Para gerar um Token você pode logar em https://inovamind.herokuapp.com/login/ com os seguintes dados de teste:

usuário: **inovamind@mail.com**
senha: **123456**

### Gerando Token de Acesso pelo Postman

Ao criar uma requisição de API, você pode obter um Token de acesso através do método `POST`, adicionando** Content-Type: application/x-www-form-urlencoded**, e os seguintes valores em Body:

key: **email**
value: **inovamind@mail.com**

key: **password**
value: **123456**

Ao realizar a requisição, um Token será gerado, copie este Token e veja o próximo tópico para ter acesso à API.

## API

Para realizar a requisição basta utilizar o método `GET` com o seguinte endpoint: https://inovamind.herokuapp.com/api/quotes/{palavra-chave}

Exemplo, acesse:

`https://inovamind.herokuapp.com/api/quotes/friendship`

### Acessar a API utilizando Token gerado

Se você estiver utilizando o browser, uma nova seção será criada quando você logar https://inovamind.herokuapp.com/login/. Então basta utilizar a URL da API.

Se estiver utilizando outro método, adicione o Token gerado no header da sua requisição, da seguinte forma:

Método: **GET**
Content-Type: **application/x-www-form-urlencoded**
Authorization:** {Token}**

## Funcionalidades

Esta API utiliza MongoDB para criar um cache com as pesquisas de palavras-chaves. Os passos de como funciona:

1.  Obtém a palavra-chave pesquisada através do parâmetro :search_tag.
2.  Verifica se esta palavra-chave foi pesquisada antes.
3.  Acessa a URL http://quotes.toscrape.com/tag/#{search_tag} e salva a página como um arquivo HTML.
4.  Decodifica o arquivo com Nokogiri, cria um Array com as divs que contém a classe **.quote**.
5.  Itera pela Array, separando os dados em citação, autor, link do autor, e tags, verifica se o item já foi salvo no banco, e salva.
6.  Serializa e renderiza o resultado da pesquisa do Banco em formato JSON.

Uma das principais características é que ele não mostra o resultado do Web Crawling, mas sim o que está no Banco de Dados, sendo que a parte de Scrapping é deixada para o gerenciamento de cache.

## Desafios

O primeiro desafio foi implementar o Token de acesso. De início não pensei que seria necessário criar um sistema de usuários. Mas então decidi que seria interessante pra que a geração dos tokens pudessem ser dinâmicas. Demorei várias horas de pesquisa, e também testei algumas gems diferentes.

Outro desafio foi realizar o deploy para o Heroku. É a primeira vez que trabalho com o MongoDB, e de início tive um pouco de dificuldades de configurá-lo no servidor. Além disso a versão do Rails 5.2.3 tem um sistema diferente de variáveis de ambiente. Ao invés do <%= ENV['SECRET_KEY_BASE'] %>, é algo como Rails.application.secrets.secret_key_base, e estava dando nil no servidor. Gastei algumas horas para tentar resolver esta questão.

## Extras

A funcionalidade extra é a parte de acessar à API através do Browser utilizando uma sessão. Pensei que seria mais interessante para que pudessem efetuar os testes do demo de uma forma mais rápida e direta.

## Considerações Finais

Tenho alguns projetos que foram feitos no Rails, utilizando Postgresql e Mysql, tenho um pouco mais de 3 anos de experiência, ainda não tive oportunidades de trabalhar em time (exceto por um período curto em mobile), e a distância remoto. Atualmente estou estudando Rails mais a fundo e tenho interesse de adquirir as habilidades necessárias para trabalhar remotamente seja aqui no Brasil ou no exterior.

Agradeço a oportunidade de desenvolver este projeto, gostei bastante da ideia, e isso me ajudou a perceber novas possibilidades de desenvolvimento.
