class Post < ApplicationRecord
  include PgSearch::Model
  include MeiliSearch::Rails

  extend Pagy::Meilisearch
  ActiveRecord_Relation.include Pagy::Meilisearch

  belongs_to :author

  after_create_commit { broadcast_append_to 'posts' }
  after_update_commit { broadcast_replace_to 'posts' }
  after_destroy_commit { broadcast_remove_to 'posts' }

  pg_search_scope :search,
                  against: { title: 'A', body: 'B' },
                  associated_against: { author: { name: 'A', city: 'B' } },
                  using: { tsearch: { prefix: true } }

  meilisearch do
    attribute :title, :body
    attribute :created_at do
      created_at.to_i
    end

    attribute :author do
      author.name
    end

    sortable_attributes %i[created_at]
  end
end
