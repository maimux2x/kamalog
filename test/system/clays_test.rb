require 'application_system_test_case'

class ClaysTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = studios(:wonderland)
  end

  test '土の一覧が表示できること' do
    visit studio_clays_path(@studio)

    assert_text '白土'
    assert_text '黒土'
  end

  test '土が0個のスタジオで新規登録できること' do
    studio = studios(:mirrorland)

    visit new_studio_clay_path(studio)

    assert_equal 0, studio.clays.count

    fill_in '名前', with: '大島耐火'
    click_on '登録する'

    assert_text '土を登録しました。'
    assert_text '大島耐火'
  end

  test '同じ名前の土は登録できないこと' do
    visit new_studio_clay_path(@studio)

    fill_in '名前', with: '白土'
    click_on '登録する'

    assert_text 'はすでに存在します'
  end

  test '土の更新ができること' do
    visit edit_studio_clay_path(@studio, clays(:white))

    fill_in '名前', with: '白土（磁器土）'
    click_on '更新する'

    assert_text '土を更新しました。'
    assert_text '白土（磁器土）'
  end

  test '作品で使用されている土は削除できないこと' do
    visit studio_clays_path(@studio)

    within 'ul.list-group li:first-child' do
      click_on '削除'
    end

    assert_text 'すでに作品で使用されているため削除できません。'
    assert_text '白土'
    assert_text '黒土'
  end

  test '作品で使用されていない土は削除できること' do
    clays(:black).clay_usages.destroy_all

    visit studio_clays_path(@studio)

    within 'ul.list-group li:nth-child(2)' do
      click_on '削除'
    end

    assert_text '土を削除しました。'

    within 'ul.list-group li:nth-child(1)' do
      assert_text '白土'
    end

    within 'ul.list-group li:nth-child(2)' do
      assert_text '赤土'
    end

    assert_no_text '黒土'
  end
end
