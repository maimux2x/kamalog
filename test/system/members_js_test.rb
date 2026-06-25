require 'application_system_test_case'

class MembersJsTest < ApplicationSystemTestCase
  driven_by_simulated

  setup do
    visit root_path
    sign_in_as users(:alice)

    @studio = users(:alice).studios.first
  end

  test 'メンバーの招待を切り替えできること' do
    visit studio_members_path(@studio)

    check 'メンバーの招待'

    assert_text 'メンバーの招待を無効にしました。'
    assert_no_field '招待用URL'

    check 'メンバーの招待'

    assert_text 'メンバーの招待を有効にしました。'
    assert_field '招待用URL'
  end
end
