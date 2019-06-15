class Api::Quotes::QuotesController < Api::Quotes::ApiController
    def show
        require 'open-uri'
        require 'nokogiri'
        require 'json'

        url = 'http://quotes.toscrape.com/'
        html = open(url)

        doc = Nokogiri::HTML(html)
        
        quotes = doc.css("div.quote")
        bridges = []

        #json = JSON.pretty_generate(bridges)
        # File.open("data.json", 'w') { 
        #     |file| file.write(json) 
        # }

        puts "Debugging<<<<<<<<<<<<<<"
        quotes.each_with_index do |div, index|
            quote_test = div.css("span.text")[0].text
            author = div.css("small.author").text
            author_about_link = div.css("a")[0]['href']
            keywords = div.css("meta.keywords")[0]['content']
        end

        puts params[:search_tag]
        render json: "teste"
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