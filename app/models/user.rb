class User < ActiveRecord::Base
  
  has_many :bets, foreign_key: :user_owner_id
  has_many :posts
	
  validates :name, :email, :surname, presence: true
  validates :email, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
  					:default_url => ActionController::Base.helpers.asset_path('missing.png')
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  after_validation(on: :create) do 
    self.credit = 1000
  end
  
end
