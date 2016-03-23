class AddAttachmentAvatarToAdmins < ActiveRecord::Migration
   def change
    add_attachment :admins, :avatar
  end
end
