class Quote
  include Mongoid::Document
  include ActiveModel::Serialization
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array

  validates_uniqueness_of :quote, presence: true

  protected
  
  # 1. Acessa URL e obtém o documento por completo #
  def self.search_data (search_tag)
    require 'open-uri'
    url = "http://quotes.toscrape.com/tag/#{search_tag}"

    begin
        html = open(url)
        json_data = process_data (html) # Filtrar dados necessários
    rescue => error
        puts error.inspect
    end

    return json_data.to_json
  end

  # 2. Filtra Html dos Dados #
  def self.process_data(html)
    require 'nokogiri'
    require 'json'
    doc = Nokogiri::HTML(html)
    quotes = doc.css("div.quote")
    json_data = []
    quotes.each_with_index do |div, index|
        quote = div.css("span.text")[0].text,
        author = div.css("small.author").text,
        author_about = div.css("a")[0]['href'],
        tags=  div.css("meta.keywords")[0]['content']
        #Save individual quotes (avoid duplicates)
        save_data index, quote, author, author_about, tags

        json_data.push(
            quote: quote,
            author: author,
            author_about: author_about,
            tags: tags
        )
    end
    return json_data
  end

  # 3. Salva Infos no banco de Dados #
  def self.save_data (index, quote, author, author_about, tags)
    quotedb = Quote.new
    quotedb.quote = quote
    quotedb.author = author
    quotedb.author_about = author_about
    quotedb.tags = tags.split(',') # Converte string com vírglas em Array
    begin
        quotedb.save!
    rescue => error
        puts "Autor #{index} já existe"
    end
  end


end
