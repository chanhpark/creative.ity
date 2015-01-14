class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_attached_file :image, styles: { medium: "700x500#", small: "350x250>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true
  validates :link, presence: true
  acts_as_votable

  def self.search(query)
    if query
      where(
      "plainto_tsquery(?) @@ " +
      "to_tsvector('english', LOWER(title) || ' ' || description)",
      query
      )
    else
      all
    end
  end
end
