class Api::Quotes::QuotesController < Api::Quotes::ApiController

    def show
        search_tag = params[:search_tag]
        
        search_cache = SearchCache.where(tag: search_tag)
        if(search_cache.blank?)
            json_data = Quote.search_data(search_tag)
            SearchCache.create(tag: search_tag)
        end

        render json: Quote.where(tags: search_tag), each_serializer: QuoteSerializer

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