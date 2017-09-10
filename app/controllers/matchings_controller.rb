class MatchingsController < ApplicationController
  protect_from_forgery with: :null_session
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
    matching_max = 3
    timeout = 20
    matched_group = Matchedgroup.where(userid1: params[:userid].to_i).or(Matchedgroup.where(userid2: params[:userid].to_i)).or(Matchedgroup.where(userid3: params[:userid].to_i)).where(closed_flag: 1).where(delete_flag: 0).first
    if matched_group.nil?
      render :json => {result: false}
    else
      if matched_group.report < matched_group.members
        matched_group.update_attribute(:report, matched_group.report + 1)
        render :json => {result: true, taxi_number: matched_group.taxi_number, taxi_lat: matched_group.taxi_lat, taxi_lng: matched_group.taxi_lng}
      end
    end
  end

end
