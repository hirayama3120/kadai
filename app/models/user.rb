class User < ApplicationRecord

  def do_inactive(id)
    user = User.find_by(id)      
    user.DeleteFlag = 1
    user.save
  end

#  def do_inactive
#    update(DeleteFlag: 1)
#  end
end
