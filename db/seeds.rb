studio = Studio.find_or_create_by!(name: 'ワンダーランドスタジオ')

10.times do
  email = "test#{it}@example.com"

  user = User.find_or_initialize_by(email:)
  user.update! uid: email, name: "test#{it}"
  user.memberships.find_or_create_by! studio: studio
end

membership = User.find_by!(email: 'test1@example.com').memberships.find_or_create_by!(studio:)
membership.admin!

white_clay, _, black_clay = ['白土', '赤土', '黒土'].map.with_index(1) {|name, i|
  studio.clays.find_or_initialize_by(name:).tap { it.update! position: i }
}

white_matte, perl, black_matte = ['白マット', 'パールラスター', '黒マット'].map.with_index(1) {|name, i|
  studio.glazes.find_or_initialize_by(name:).tap { it.update! position: i }
}

rice_bowl = membership.pieces.find_or_initialize_by(title: 'お茶碗')
rice_bowl.update! form_method: :electric_wheel

rice_bowl.clay_usages.find_or_initialize_by(clay: white_clay).tap { it.update! weight: 500 }
rice_bowl.glaze_usages.find_or_create_by! glaze: white_matte

log = rice_bowl.logs.find_or_initialize_by(title: '電動ロクロでお茶碗を作る')
log.update! date: '2026-05-01', body: 'プレゼント用に小さなお茶碗を作り始めた。'

4.times do |i|
  photo = log.photos.find_or_initialize_by(caption: "#{i}テストテストテストテストテストテストテストテスト")
  photo.file.attach io: File.open("app/assets/images/IMG_077#{i}.jpg"), filename: "IMG_077#{i}.jpg"
end

dish = membership.pieces.find_or_initialize_by(title: 'お皿')
dish.update! form_method: :hand_building, status: :complete, description: '友達に上げるためのお皿を作った。'

4.times do |i|
  photo = dish.photos.find_or_initialize_by(caption: "#{i}テストテストテストテストテストテストテストテスト")
  photo.file.attach io: File.open("app/assets/images/IMG_077#{i}.jpg"), filename: "IMG_077#{i}.jpg"
end

dish.clay_usages.find_or_initialize_by(clay: white_clay).tap { it.update! weight: 500 }
dish.glaze_usages.find_or_create_by! glaze: white_matte

log = dish.logs.find_or_initialize_by(title: '手びねりでお皿を作る')
log.update! date: '2026-05-10', body: 'お菓子を食べるときに使ってほしい'

4.times do |i|
  photo = log.photos.find_or_initialize_by(caption: "#{i}テストテストテストテストテストテストテストテスト")
  photo.file.attach io: File.open("app/assets/images/IMG_077#{i}.jpg"), filename: "IMG_077#{i}.jpg"
end

cup = membership.pieces.find_or_initialize_by(title: 'マグカップ')
cup.update! form_method: :coil_building

cup.clay_usages.find_or_initialize_by(clay: black_clay).tap { it.update! weight: 300 }
cup.glaze_usages.find_or_create_by! glaze: black_matte
cup.glaze_usages.find_or_create_by! glaze: perl

log = cup.logs.find_or_initialize_by(title: '紐作りでマグカップ作り')
log.update! date: '2026-04-05', body: '好きな作家さんの作風を参考に作ってみる。'

log = cup.logs.find_or_initialize_by(title: '削りで形を整える')
log.update! date: '2026-04-12', body: '削りを入れて凹凸や底の厚みを削って形を整えた。'

4.times do |i|
  photo = log.photos.find_or_initialize_by(caption: "#{i}テストテストテストテストテストテストテストテスト")
  photo.file.attach io: File.open("app/assets/images/IMG_077#{i}.jpg"), filename: "IMG_077#{i}.jpg"
end

base = membership.pieces.find_or_initialize_by(title: '花瓶')
base.update! form_method: :coil_building, status: :complete, description: '一輪挿しを作った。'

4.times do |i|
  photo = base.photos.find_or_initialize_by(caption: "#{i}テストテストテストテストテストテストテストテスト")
  photo.file.attach io: File.open("app/assets/images/IMG_077#{i}.jpg"), filename: "IMG_077#{i}.jpg"
end

base.clay_usages.find_or_initialize_by(clay: black_clay).tap { it.update! weight: 300 }
base.glaze_usages.find_or_create_by! glaze: black_matte
base.glaze_usages.find_or_create_by! glaze: perl

log = base.logs.find_or_initialize_by(title: '高さを出す練習で花瓶を作った')
log.update! date: '2026-04-05', body: '雰囲気がある花瓶になった。'

4.times do |i|
  photo = log.photos.find_or_initialize_by(caption: "#{i}テストテストテストテストテストテストテストテスト")
  photo.file.attach io: File.open("app/assets/images/IMG_077#{i}.jpg"), filename: "IMG_077#{i}.jpg"
end

studio2 = Studio.find_or_create_by!(name: 'ミラーランドスタジオ')

user = User.find_or_initialize_by(email: 'test1@example.com')
user.memberships.find_or_create_by! studio: studio2

membership = User.find_by!(email: 'test1@example.com').memberships.find_or_create_by!(studio: studio2)
membership.admin!

['白土', '赤土', '黒土'].each.with_index 1 do |name, i|
  studio2.clays.find_or_initialize_by(name:).update! position: i
end

['白マット', 'パールラスター', '黒マット'].each.with_index 1 do |name, i|
  studio2.glazes.find_or_initialize_by(name:).update! position: i
end
