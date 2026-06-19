require 'application_system_test_case'

class Glazes::BulksTest < ApplicationSystemTestCase
  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = users(:alice).memberships.first.studio
  end

  test '釉薬を一括登録できること' do
    visit new_studio_glazes_bulk_path(@studio)

    fill_in '名前', with: <<~TEXT
      釉薬A
      釉薬B
      釉薬C
    TEXT

    click_on '一括登録'

    assert_text '3件の釉薬を一括登録しました。'
    assert_text '釉薬A'
    assert_text '釉薬B'
    assert_text '釉薬C'
  end

  test '保存済みの釉薬はスキップされること' do
    visit new_studio_glazes_bulk_path(@studio)

    fill_in '名前', with: <<~TEXT
      白マット
      黒マット
      釉薬A
    TEXT

    click_on '一括登録'

    assert_text '1件の釉薬を一括登録しました。'
    assert_text '釉薬A'
  end

  test '空や空白の行は保存されないこと' do
    visit new_studio_glazes_bulk_path(@studio)

    # rubocop:disable Layout/TrailingWhitespace
    fill_in '名前', with: <<~TEXT
         

      釉薬A
    TEXT
    # rubocop:disable Layout/TrailingWhitespace

    click_on '一括登録'

    assert_text '1件の釉薬を一括登録しました。'
    assert_text '釉薬A'
  end
end
