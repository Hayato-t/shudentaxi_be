class FeelingsController < ApplicationController
  protect_from_forgery with: :null_session
  def add
    radius = 1

    new_feeling = Feeling.new
    new_feeling.userid = params[:userid].to_i
    new_feeling.comment_body = params[:comment_body]
    new_feeling.comment_lat = params[:here_lat].to_f
    new_feeling.comment_lng = params[:here_lng].to_f
    new_feeling.save!
    
    new_matching = Matching.new
    new_matching.userid = params[:userid].to_i
    new_matching.here_lat = params[:here_lat].to_f
    new_matching.here_lng = params[:here_lng].to_f
    new_matching.obj_lat = params[:obj_lat].to_f
    new_matching.obj_lng = params[:obj_lng].to_f
    new_matching.save!
    
    latlng_distance = get_latlng_distance_from_radius(radius)
    nearby_comments = Feeling.where(comment_lng: params[:here_lng].to_f-latlng_distance..params[:here_lng].to_f+latlng_distance)\
                      .where(comment_lat: params[:here_lat].to_f-latlng_distance..params[:here_lat].to_f+latlng_distance).all
    #TODO 半径1km以内のものだけ選定するために球面距離の式をつかう
    render :json => {comments: nearby_comments, result: true}
    
  end
  private
  def get_latlng_distance_from_radius(radius)
    radius * 0.011
  end

    
end
