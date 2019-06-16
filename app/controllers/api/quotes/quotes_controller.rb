class Api::Quotes::QuotesController < Api::Quotes::ApiController

    def show
        search_tag = params[:search_tag]
        
        # Verificar se Pesquisa já foi realizada
        search_cache = SearchCache.where(tag: search_tag)

        if(search_cache.blank?)
            json_data = Quote.search_data(search_tag)
            SearchCache.create(tag: search_tag) unless json_data.blank?
        end

        render json: Quote.where(tags: search_tag), each_serializer: QuoteSerializer

    end
end

# http://quotes.toscrape.com/.