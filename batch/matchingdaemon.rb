class MatchingBatch
  SLEEP = 5
  def self.execute
    loop do
      print("start batch\n")
      waiting = Matching.where(paired_flag: 0).all
      all_taxis = Taxiallotment.all
      matchedgroups = Matchedgroup.where(closed_flag: 0).where(delete_flag: 0).all
      waiting.each do |person|
        samedestination_group = matchedgroups.find{|group| latlng_to_distance(person.obj_lat,person.obj_lng,group.taxi_lat,group.taxi_lng) <= 1 and latlng_to_distance(person.obj_lat,person.obj_lng,group.obj_lat,group.obj_lng) <= 1}
        if samedestination_group.present? and samedestination_group.members < 3
          print("samedestination_group found!\n")
          samedestination_group.members += 1
          if samedestination_group.members == 3
            samedestination_group.userid3 = person.userid
          elsif samedestination_group.members == 2
          samedestination_group.userid2 = person.userid
          else
            samedestination_group.userid1 = person.userid
          end
          samedestination_group.save!
          person.paired_flag = 1
          person.save!
        end
      end

      nogroup = Matching.where(paired_flag: 0).all
      nogroup.each do |a|
        nogroup.each do |b|
          print("checking nogroup\n")
          if a.userid != b.userid
            if a.paired_flag == 0 and b.paired_flag == 0
              print(latlng_to_distance(a.here_lat,a.here_lng,b.here_lat,b.here_lng))
              print(latlng_to_distance(a.obj_lat,a.obj_lng,b.obj_lat,b.obj_lng))
              if latlng_to_distance(a.here_lat,a.here_lng,b.here_lat,b.here_lng) <= 1 and latlng_to_distance(a.obj_lat,a.obj_lng,b.obj_lat,b.obj_lng) <= 1
                print("entered\n")
                new_matchedgroup = Matchedgroup.new
                new_matchedgroup.members = 2
                new_matchedgroup.userid1 = a.userid
                new_matchedgroup.userid2 = b.userid
                taxi_points = Taxiallotment.all
                taxi_points.sort_by{|point| latlng_to_distance((a.here_lat + b.here_lat)/2,(a.here_lng + b.here_lng)/2,point.lat,point.lng)}
                near_taxi = taxi_points[0]
                new_matchedgroup.taxi_number = '111-111'
                new_matchedgroup.taxi_lat = near_taxi.lat
                new_matchedgroup.taxi_lng = near_taxi.lng
                new_matchedgroup.obj_lat = (a.obj_lat + b.obj_lat)/2
                new_matchedgroup.obj_lng = (a.obj_lng + b.obj_lng)/2
                new_matchedgroup.closed_flag = 0
                new_matchedgroup.delete_flag = 0
                new_matchedgroup.report = 0
                new_matchedgroup.save!
                a.paired_flag = 1
                b.paired_flag = 1
                a.save!
                b.save!
              end
            end
          end
        end
      end

      # matched group flag
      all_matchedgroups = Matchedgroup.where(delete_flag: 0).all
      all_matchedgroups.each do |group|
        print("checking matchedgroup")
        if (group.created_at + 20 < Time.now or group.members == 3) and group.closed_flag == 0
          print("change closedflag")
          group.closed_flag = 1
          group.save!
        end
        if group.report == group.members
          group.delete_flag = 1
          group.save!
        end
      end
      sleep SLEEP
    end
  end
  def self.latlng_to_distance(lat1,lng1,lat2,lng2)
    inp = Math::sin(radian(lat2-lat1)/2)**2 + Math::cos(radian(lat2))*Math::cos(radian(lat1))*(Math::sin(radian(lng2-lng1)/2)**2)
    6371 * 2 * Math::asin(Math::sqrt(inp))
  end
  def self.radian(deg)
    deg * 3.141592653589793116 / 180.0
  end
end

MatchingBatch.execute
