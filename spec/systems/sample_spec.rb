it 'ログイン' do
  visit root_path
  expect(page).to_not have_content 'マイページ' # ログイン前はマイページという表示が無い
  page.set_rack_session(uid: user.uid) # ログイン
  visit root_path
  expect(page).to have_content 'マイページ' # マイページと表示されている
end
