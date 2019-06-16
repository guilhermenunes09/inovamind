class Api::Quotes::QuotesController < Api::Quotes::ApiController

    def show
        search_tag = params[:search_tag]
        
        # Verificar se Pesquisa já foi realizada
        search_cache = SearchCache.where(tag: search_tag)

        if(search_cache.blank?)
            json_data = Quote.search_data(search_tag)
            SearchCache.create(tag: search_tag) unless json_data.blank?
        end
        quotes = Quote.where(tags: search_tag)
        if(quotes.present?)
            render json: quotes, each_serializer: QuoteSerializer
        else
            render json: { message: "Nenhuma citação encontrada com a palavra chave [#{search_tag}]." }, status: 209
        end

    end
end

# http://quotes.toscrape.com/.