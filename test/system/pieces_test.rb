require 'application_system_test_case'

class PiecesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)
  end

  test 'みんなの作品一覧を表示できること' do
    visit pieces_path

    assert_text     '湯呑み'
    assert_text     '小鉢'
    assert_text     'Aliceさんの作品'
    assert_text     'Bobさんの作品'
    assert_selector 'img[src$="/dish_cup.png"]'
  end

  test '作品詳細を表示する' do
    visit piece_path(pieces(:teacup))

    assert_text '湯呑み'

    within 'dd:nth-child(2)' do
      assert_text 'Alice'
    end

    assert_selector 'img[src$="/dish_cup.png"]'
    assert_text     '湯呑みの説明'
    assert_text     '自宅用の小さな湯呑みを作った'
  end

  test '自分以外のユーザーの作品詳細を表示する' do
    visit piece_path(pieces(:small_bowl))

    assert_text '小鉢'

    within 'dd:nth-child(2)' do
      assert_text 'Bob'
    end
  end
end
