user = User.create!(uid: 'test1@example.com', name: 'test1', email: 'test1@example.com')

['白土', '赤土', '黒土'].each do |clay|
  Clay.create!(name: clay)
end

['白マット', 'パールラスター', '黒マット'].each do |glaze|
  Glaze.create!(name: glaze)
end

white_clay  = Clay.find_by(name: '白土')
white_matte = Glaze.find_by(name: '白マット')
rice_bowl   = user.pieces.create!(title: 'お茶碗', form_method: :electric_wheel)

rice_bowl.clay_usages.create!(clay: white_clay, weight: 500)
rice_bowl.glaze_usages.create!(glaze: white_matte)

black_clay  = Clay.find_by(name: '黒土')
black_matte = Glaze.find_by(name: '黒マット')
perl        = Glaze.find_by(name: 'パールラスター')
cup         = user.pieces.create!(title: 'マグカップ', form_method: :coil_building)

cup.clay_usages.create!(clay: black_clay, weight: 300)
cup.glaze_usages.create!(glaze: black_matte)
cup.glaze_usages.create!(glaze: perl)
