class User < ApplicationRecord
#  def do_inactive(id, attributes)
#    object = User.find(id)
#    object.do_inactive(attributes)
#    object
#  end
  def do_inactive
    update(DeleteFlag: 1)
  end
end
