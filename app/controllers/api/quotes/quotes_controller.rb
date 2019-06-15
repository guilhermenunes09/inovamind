class Api::Quotes::QuotesController < Api::Quotes::ApiController
    def show
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