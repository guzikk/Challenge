class Bet < ActiveRecord::Base
 
  belongs_to :user_owner, class_name: "User"
  belongs_to :user_participant, class_name: "User"
  has_many :posts

 	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
 	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_attached_file :proof, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
 	validates_attachment_content_type :proof, :content_type => /\Aimage\/.*\Z/

 	validates :name, :description, :end_date_of_challenge, presence: true
 	
  after_validation(on: :create) do 
   	self.active = false
    self.credit = 1000
  end

  scope :active, ->{where active:true, status: 1}
  scope :finished, ->{where active: true, status: 0}
  scope :inactive, ->{where active:false}	

end