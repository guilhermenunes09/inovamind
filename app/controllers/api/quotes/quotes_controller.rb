class Api::Quotes::QuotesController < Api::Quotes::ApiController

    def save_data (index, quote, author, author_about, tags)
        quotedb = Quote.new
        quotedb.quote = quote
        quotedb.author = author
        quotedb.author_about = author_about
        quotedb.tags = tags
        begin
            quotedb.save!
        rescue => error
            puts "Autor #{index} já existe"
        end
    end

    def process_data(html)
        doc = Nokogiri::HTML(html)
        quotes = doc.css("div.quote")
        json_data = []
        puts "Debugging<<<<<<<<<<<<<<"
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

    def search_data (search_tag)
        require 'open-uri'
        require 'nokogiri'
        require 'json'
        
        url = "http://quotes.toscrape.com/tag/#{search_tag}"

        begin
            html = open(url)
            json_data = process_data (html)
        rescue
            logger.error ex.message
        end

        
        return json_data.to_json
    end

    def show
        search_tag = params[:search_tag]
        json_data = search_data(search_tag)
        render json: json_data
    end
end

#http://quotes.toscrape.com/.

# render json: {
#     quotes: [
#         {
#         quote: "frase",
#         author: "nome do autor",
#         author_about: "link para o perfil do autor",
#         tags: ["tag1", "tag2"]
#         }
#     ]
# }.to_json