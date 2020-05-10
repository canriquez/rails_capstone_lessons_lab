require 'rails_helper'

feature 'create new course' do
  scenario 'create course with valid data' do
    visit('/groups')
    click_on('Add New Course')

    fill_in('Course Name', with: 'Course 1')
    fill_in('Description', with: 'this is a dummy description for testing purposes only')
    select('45', from: 'Duration' )
    fill_in('Price', with: 'Price')
    check('Online Session')
    check('Presencial Session')
    check('Classroom Ready')
    fill_in('Starting from', with:'05/08/2020')
    attach_file('Course Image', "#{Rails.root}/spec/fixtures/ielts_cover_image.jpeg")
    click_on('Save Course')

    expect(page).to have_content('Course has been created')
    expect(Group.last.name).to eq('Course 1')
  end

  scenario 'failing to create achievement with invalid data' do
    visit('/groups')
    click_on('Add New Course')

    click_on('Save Course')
    expect(page).to have_content("can't be blank")
  end
  
end
