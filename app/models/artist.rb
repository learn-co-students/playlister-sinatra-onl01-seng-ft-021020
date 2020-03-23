class Artist < ActiveRecord::Base
  has_many :songs
  has_many :song_genres, through: :songs
  has_many :genres, through: :song_genres

  def slug
    self.name.downcase.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    # Artist.find_by(name: slug.gsub('-', ' ').titlecase)
    Artist.where('lower(name) = ?', slug.gsub('-', ' ')).first
  end

end
