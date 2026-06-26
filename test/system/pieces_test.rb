require 'application_system_test_case'

class PiecesTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)
  end

  test 'みんなの作品を表示できること' do
    visit studio_pieces_path(users(:alice).studios.first)

    assert_text     '湯呑み'
    assert_text     '小鉢'
    assert_text     'Aliceさんの作品'
    assert_text     'Bobさんの作品'
    assert_selector 'img[src$="/dish_cup.png"]'
  end

  test '自分の作品詳細を表示する' do
    visit studio_piece_path(users(:alice).studios.first, pieces(:teacup))

    assert_text '湯呑み'

    within 'dd:nth-child(2)' do
      assert_text 'Alice'
    end

    assert_selector 'img[src$="/dish_cup.png"]'
    assert_text     '湯呑みの説明'
    assert_text     '自宅用の小さな湯呑みを作った'
  end

  test '自分以外のユーザーの作品詳細を表示する' do
    visit studio_piece_path(memberships(:bob_membership).studio, pieces(:small_bowl))

    assert_text '小鉢'

    within 'dd:nth-child(2)' do
      assert_text 'Bob'
    end
  end
end
