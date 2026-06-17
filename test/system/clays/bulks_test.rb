require 'application_system_test_case'

class Clays::BulksTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:alice)

    @studio = users(:alice).memberships.first.studio
  end

  test '土を一括登録できること' do
    visit new_studio_clays_bulk_path(@studio)

    fill_in '名前', with: <<~TEXT
      土A
      土B
      土C
    TEXT

    click_on '一括登録'

    assert_text '3件の土を一括登録しました。'
    assert_text '土A'
    assert_text '土B'
    assert_text '土C'
  end

  test 'すでに保存済みの土はスキップされること' do
    visit new_studio_clays_bulk_path(@studio)

    fill_in '名前', with: <<~TEXT
      白土
      黒土
      土A
    TEXT

    click_on '一括登録'

    assert_text '1件の土を一括登録しました。'
    assert_text '土A'
  end

  test '空や空白だけの行は保存されないこと' do
    visit new_studio_clays_bulk_path(@studio)

    # rubocop:disable Layout/TrailingWhitespace
    fill_in '名前', with: <<~TEXT
         

      土A
    TEXT
    # rubocop:disable Layout/TrailingWhitespace

    click_on '一括登録'

    assert_text '1件の土を一括登録しました。'
    assert_text '土A'
  end
end
