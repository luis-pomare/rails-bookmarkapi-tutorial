require 'rails_helper'

describe 'POST /bookmarks' do
  # create a user before the test scenarios are run
  let!(:user) { User.create(username: 'soulchild', authentication_token: 'abcdef') }

  # pass the user username and authentication to the header
  scenario 'valid bookmark attributes' do
    post '/bookmarks', params: {
      bookmark: {
        url: 'https://rubyyagi.com',
        title: 'RubyYagi blog'
      }
    }, headers: { 'X-Username': user.username, 'X-Token': user.authentication_token }
  # ...
  end

  # pass the user username and authentication to the header
  scenario 'invalid bookmark attributes' do
    post '/bookmarks', params: {
      bookmark: {
        url: '',
        title: 'RubyYagi blog'
      }
    }, headers: { 'X-Username': user.username, 'X-Token': user.authentication_token }
  # ...
  end
end
