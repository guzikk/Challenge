class Bet < ActiveRecord::Base
 
  belongs_to :user_owner, class_name: "User"
  belongs_to :user_participant, class_name: "User"
  belongs_to :user_winner, class_name: "User"
  has_many :posts, dependent: :destroy

 	has_attached_file :proof, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
 	validates_attachment_content_type :proof, :content_type => /\Aimage\/.*\Z/

 	validates :name, :description, :end_date_of_challenge, :credit, presence: true
 	
  after_validation(on: :create) do 
   	self.active = false
    self.status = 1
  end

  scope :active, ->{where active:true, status: 1}
  scope :finished, ->{where status: 0}
  scope :inactive, lambda { |user|
    where(:user_owner_id => user.id, active:false, :status => 1) 
  }

  scope :my_bets_owner, lambda { |user|
    where(:user_owner_id  => user.id) 
  }

  scope :my_bets_participant, lambda { |user|
    where(:user_participant_id => user.id) 
  }
   
end