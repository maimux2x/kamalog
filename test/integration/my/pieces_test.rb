require 'test_helper'

class My::PiecesTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid:      '12345',

      info: {
        name:  'Alice',
        email: 'alice@example.com'
      }
    )

    get '/auth/google_oauth2/callback'
  end

  teardown do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  test 'index (in_progress)' do
    get my_in_progress_index_path

    assert_response :ok
    assert_dom 'a', '制作する作品を登録'
  end

  test 'show' do
    get my_piece_path(pieces(:cup))

    assert_response :ok
    assert_dom 'a', '編集'
  end

  test 'new' do
    get new_my_piece_path

    assert_response :ok

    assert_dom 'input[type="submit"][value="登録する"]'
  end

  test 'create' do
    post my_pieces_path, params: {
      piece: {
        title:       'お皿',
        status:      :in_progress,
        form_method: :electric_wheel,

        clay_usages_attributes: [
          {
            clay_id: clays(:white).id,
            weight: 100
          }
        ]
      }
    }

    assert_response :see_other

    piece = Piece.last
    assert_redirected_to my_piece_path(piece)

    follow_redirect!

    assert_dom 'h1', 'お皿'

    assert_equal 'お皿',           piece.title
    assert_equal 'in_progress',    piece.status
    assert_equal 'electric_wheel', piece.form_method

    assert_equal '白土', piece.clays.first.name
    assert_equal 100,    piece.clay_usages.first.weight
  end

  test 'edit' do
    get edit_my_piece_path(pieces(:cup))

    assert_response :ok
    assert_dom 'input[type="submit"][value="更新する"]'
  end

  test 'update' do
    cup = pieces(:cup)

    patch my_piece_path(cup), params: {
      piece: {
        clay_usages_attributes: [
          {
            clay_id: clays(:black).id,
            weight:  50
          }
        ]
      }
    }

    assert_response :see_other
    assert_redirected_to my_piece_path(cup)

    follow_redirect!

    assert_equal '白土', cup.clays.first.name
    assert_equal 500,    cup.clay_usages.first.weight
    assert_equal '黒土', cup.clays.last.name
    assert_equal 50,    cup.clay_usages.last.weight
  end
end
