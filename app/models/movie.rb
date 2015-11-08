class Movie < ActiveRecord::Base
  
  validates :title, presence:true
  validates :director, presence:true
  validates :runtime_in_minutes,numericality: { only_integer: true }
  validates :description,presence: true
  validates :release_date,presence: true
  validate :release_date_is_in_the_past
  has_many :reviews
  mount_uploader :avatar, AvatarUploader
  
 
  def review_average
    reviews.size.zero? ? 0 : reviews.sum(:rating_out_of_ten)/reviews.size
  end 
   
  scope :search_title, ->(search){ Movie.where('title like ?', "%#{search}%") }
  scope :search_director, ->(search){Movie.where('director like ?', "%#{search}%")}
  # scope :duration_under90_search, -> { where('runtime_in_minutes < 90') }
  # scope :duration_between_90_and_120_search, -> { where('runtime_in_minutes >= 90 AND runtime_in_minutes <= 120') }
  # scope :duration_over120_search, -> { where('runtime_in_minutes > 120') }
  
  def self.search(runtime_in_minutes)
    case runtime_in_minutes
      when "1"
        @movies = Movie.where("runtime_in_minutes < 90")
      when "2"
        @movies = Movie.where("runtime_in_minutes >= 90 AND runtime_in_minutes <= 120")
      when "3"
        @movies = Movie.where("runtime_in_minutes > 120")
    end
  end

  
  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end 
end

# def self.search_title(search)
  #   Movie.where('title like ?', "%#{search}%") 
  # end

  # def self.search_director(search)
  #   Movie.where('director like ?', "%#{search}%")
  # end

