class Quote
  include Mongoid::Document
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: String

  validates_uniqueness_of :quote, presence: true
end
