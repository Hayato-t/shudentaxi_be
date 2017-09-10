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

    latlng_distance = get_latlng_distance_from_radius(radius)
    nearby_comments = Feeling.where(comment_lng: params[:here_lng].to_f-latlng_distance..params[:here_lng].to_f+latlng_distance)\
                      .where(comment_lat: params[:here_lat].to_f-latlng_distance..params[:here_lat].to_f+latlng_distance).all
    comments_in_range = nearby_comments.map do |comment|
      lat1 = comment.comment_lat
      lng1 = comment.comment_lng
      lat2 = params[:here_lat].to_f
      lng2 = params[:here_lng].to_f
      inp = Math::sin(radian(lat2-lat1)/2)**2 + Math::cos(radian(lat2)) * Math::cos(radian(lat1)) * (Math::sin(radian(lng2 - lng1)/2)**2)
      d = 6371 * 2 * Math::asin(Math::sqrt(inp))
      if d <= radius
        comment
      else 
        next
      end
    end
    comments_in_range.compact!
    
    new_matching = Matching.new
    new_matching.userid = params[:userid].to_i
    new_matching.here_lat = params[:here_lat].to_f
    new_matching.here_lng = params[:here_lng].to_f
    new_matching.obj_lat = params[:obj_lat].to_f
    new_matching.obj_lng = params[:obj_lng].to_f
    new_matching.paired_flag = 0
    new_matching.save!
    
    render :json => {comments: comments_in_range, result: true}
    
  end

  private
  def get_latlng_distance_from_radius(radius)
    radius * 0.011
  end
  def radian(deg)
    mypi = 3.141592653589793116
    deg * mypi / 180.0
  end
    
end
