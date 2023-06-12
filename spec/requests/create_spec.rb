require 'rails_helper'

describe 'POST /bookmarks' do
  let!(:user) { User.create(username: 'soulchild', authentication_token: 'abcdef') }
  
  scenario 'valid bookmark attributes' do
    post '/bookmarks', params: {
      bookmark: {
        url: 'https://rubyyagi.com',
        title: 'RubyYagi blog'
      }
    }, headers: { 'X-Username': user.username, 'X-Token': user.authentication_token }

    # response should have HTTP Status 201 Created
    expect(response.status).to eq(201)

    json = JSON.parse(response.body).deep_symbolize_keys
    
    # check the value of the returned response hash
    expect(json[:url]).to eq('https://rubyyagi.com')
    expect(json[:title]).to eq('RubyYagi blog')

    # 1 new bookmark record is created
    expect(Bookmark.count).to eq(1)

    # Optionally, you can check the latest record data
    expect(Bookmark.last.title).to eq('RubyYagi blog')
  end

  scenario 'invalid bookmark attributes' do
    post '/bookmarks', params: {
      bookmark: {
        url: '',
        title: 'RubyYagi blog'
      }
    }, headers: { 'X-Username': user.username, 'X-Token': user.authentication_token }

    # response should have HTTP Status 201 Created
    expect(response.status).to eq(422)

    json = JSON.parse(response.body).deep_symbolize_keys
    expect(json[:url]).to eq(["can't be blank"])

    # no new bookmark record is created
    expect(Bookmark.count).to eq(0)
  end
end
