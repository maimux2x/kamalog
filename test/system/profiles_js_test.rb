require 'application_system_test_case'

class ProfilesJsTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    visit root_path
    sign_in_as users(:alice)
  end

  test 'アバター画像を設定できること' do
    visit profile_path

    attach_file file_fixture('dish_cup.png'), make_visible: true

    assert_selector 'img[src$="/dish_cup.png"]'
  end

  test 'アバター画像を削除できること' do
    visit profile_path

    attach_file file_fixture('dish_cup.png'), make_visible: true

    click_on '画像を削除'

    assert_no_selector 'img[src$="/dish_cup.png"]'
  end
end
