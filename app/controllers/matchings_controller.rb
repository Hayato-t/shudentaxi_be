class MatchingsController < ApplicationController
  def add
    new_matching = Matching.new
    new_matching.userid = params[:userid].to_i
    new_matching.obj_lat = params[:obj_lat].to_f
    new_matching.obj_lng = params[:obj_lng].to_f
    new_matching.here_lat = params[:here_lat].to_f
    new_matching.here_lng = params[:here_lng].to_f
    new_matching.save!
    render :json => {result: true}
  end

  def ismatched
    
  end
end
