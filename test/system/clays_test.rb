require 'application_system_test_case'

class ClaysTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)

    @studio = users(:alice).memberships.first.studio
  end

  test '土の一覧が表示できること' do
    visit studio_clays_path(@studio)

    assert_text '白土'
    assert_text '黒土'
  end

  test '土を新規登録できること' do
    visit new_studio_clay_path(@studio)

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
    visit studio_clays_path(@studio)

    within 'ul.list-group li:nth-child(3)' do
      click_on '削除'
    end

    assert_text    '土を削除しました。'
    assert_text    '白土'
    assert_no_text '赤土'
  end
end
