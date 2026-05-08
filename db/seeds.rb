user = User.find_or_initialize_by(email: 'test1@example.com').tap {
  it.update! uid: 'test1@example.com', name: 'test1'
}

white_clay, _, black_clay = ['白土', '赤土', '黒土'].map {|clay|
  Clay.find_or_create_by! name: clay
}

white_matte, perl, black_matte = ['白マット', 'パールラスター', '黒マット'].map {|glaze|
  Glaze.find_or_create_by! name: glaze
}

rice_bowl = user.pieces.find_or_initialize_by(title: 'お茶碗').tap {
  it.update! form_method: :electric_wheel
}

rice_bowl.clay_usages.find_or_initialize_by(clay: white_clay).tap { it.update! weight: 500 }
rice_bowl.glaze_usages.find_or_create_by! glaze: white_matte

rice_bowl.logs.find_or_initialize_by(title: '電動ロクロでお茶碗を作る').tap {
  it.update! date: Date.new(2026, 5, 1), body: 'プレゼント用に小さなお茶碗を作り始めた。'
}

cup = user.pieces.find_or_initialize_by(title: 'マグカップ').tap {
  it.update! form_method: :coil_building
}

cup.clay_usages.find_or_initialize_by(clay: black_clay).tap { it.update! weight: 300 }
cup.glaze_usages.find_or_create_by! glaze: black_matte
cup.glaze_usages.find_or_create_by! glaze: perl

cup.logs.find_or_initialize_by(title: '紐作りでマグカップ作り').tap {
  it.update! date: Date.new(2026, 4, 5), body: '好きな作家さんの作風を参考に作ってみる。'
}

cup.logs.find_or_initialize_by(title: '削りで形を整える').tap {
  it.update! date: Date.new(2026, 4, 12), body: '削りを入れて凹凸や底の厚みを削って形を整えた。'
}
