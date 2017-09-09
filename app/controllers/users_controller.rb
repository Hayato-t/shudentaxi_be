class UsersController < ApplicationController
  def new
    max_userid_user = User.all.order('userid DESC').first()
    print(max_userid_user)
    if max_userid_user.nil?
      new_userid = 1
    else
      new_userid = max_userid_user.userid + 1
    end
    new_user = User.new
    new_user.userid = new_userid
    new_user.save!
    render :json => {userid: new_userid}
  end
end
