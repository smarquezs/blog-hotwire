class Post < ApplicationRecord
  include PgSearch::Model

  belongs_to :associated_author, class_name: :Author, foreign_key: :author_id

  after_create_commit { broadcast_append_to 'posts' }
  after_update_commit { broadcast_replace_to 'posts' }
  after_destroy_commit { broadcast_remove_to 'posts' }

  pg_search_scope :search,
                  against: { title: 'A', body: 'B' },
                  associated_against: { associated_author: { name: 'A', city: 'B' } },
                  using: { tsearch: { prefix: true } }
end
