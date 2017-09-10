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
      d = distance_calculation(lat1,lng1,lat2,lng2)
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
  def vote
    target_comment = Feeling.where(id: params[:comment_id].to_i).first
    if target_comment.blank?
      render :json => {result: false}
    else
      if params[:type] == 'like'
        target_comment.like = target_comment.like + 1
      elsif params[:type] == 'fight'
        target_comment.fight = target_comment.fight + 1
      end
      target_comment.save!
      render :json => {result: true, comment_id: target_comment.id, comment_lat: target_comment.comment_lat, comment_lng: target_comment.comment_lng, comment_body: target_comment.comment_body, comment_like: target_comment.like, comment_fight: target_comment.fight}
    end
  end

  def getcomment
    radius = 1
    print(params[:lat])
    print(params[:lng])
    if params[:lat].blank? or params[:lng].blank?
      render :json => {comments: []}
    else
      latlng_distance = get_latlng_distance_from_radius(radius)
      nearby_comments = Feeling.where(comment_lng: params[:lng].to_f-latlng_distance..params[:lng].to_f+latlng_distance)\
                        .where(comment_lat: params[:lat].to_f-latlng_distance..params[:lat].to_f+latlng_distance).all
      comments_in_range = nearby_comments.map do |comment|
        lat1 = comment.comment_lat
        lng1 = comment.comment_lng
        lat2 = params[:lat].to_f
        lng2 = params[:lng].to_f
        d = distance_calculation(lat1,lng1,lat2,lng2)
        if d <= radius
          comment
        else 
          next
        end
      end
      comments_in_range.compact!
      render :json => {comments: comments_in_range}
    end
  end

  private
  def get_latlng_distance_from_radius(radius)
    radius * 0.011
  end
  def radian(deg)
    mypi = 3.141592653589793116
    deg * mypi / 180.0
  end
  def distance_calculation(lat1,lng1,lat2,lng2)
    inp = Math::sin(radian(lat2-lat1)/2)**2 + Math::cos(radian(lat2)) * Math::cos(radian(lat1)) * (Math::sin(radian(lng2 - lng1)/2)**2)
    6371 * 2 * Math::asin(Math::sqrt(inp))
  end
end
