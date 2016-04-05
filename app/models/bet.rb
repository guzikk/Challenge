class Bet < ActiveRecord::Base
 
  belongs_to :user_owner, class_name: "User"
  belongs_to :user_participant, class_name: "User"
  belongs_to :user_winner, class_name: "User"
  has_many :posts, dependent: :destroy

 	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
 	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_attached_file :proof, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
 	validates_attachment_content_type :proof, :content_type => /\Aimage\/.*\Z/

 	validates :name, :description, :end_date_of_challenge, :credit, presence: true
 	
  after_validation(on: :create) do 
   	self.active = false
    self.status = 1
  end

  scope :active, ->{where active:true, status: 1}
  scope :finished, ->{where status: 0}
  #scope :inactive, ->{where active:false, user_owner_id: current_user.id}	

  scope :inactive, lambda { |user|
    where(:user_owner_id => user.id, active:false) 
  }

end