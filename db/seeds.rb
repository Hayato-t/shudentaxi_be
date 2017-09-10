# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Feeling.create(userid: 1,comment_lat: 35.691638,comment_lng: 139.704616,comment_body: 'なんてこった！パンナコッタ！',comment_imgpath: nil,like: 0,fight: 0)
Feeling.create(userid: 2,comment_lat: 35.721638,comment_lng: 139.704616,comment_body: 'うせやん！？なんしょいな！',comment_imgpath: nil,like: 0,fight: 0)
Matching.create(userid: 1,here_lat: 35.658034 ,here_lng: 139.701636 ,obj_lat: 35.691638,obj_lng: 139.704616,paired_flag: 0)
Taxiallotment.create(lat: 35.691620,lng: 139.70)
Taxiallotment.create(lat: 35.658034,lng: 139.70)

