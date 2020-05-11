class NewGroupForm
  include Capybara::DSL

  def visit_page
    visit('/groups')
    click_on('Add New Course')
    self
  end

  def fill_in_with(params = {})
    fill_in('Course Name', with: params.fetch(:name, 'Course 1'))
    fill_in('Description', with: 'this is a dummy description for testing purposes only')
    select('45', from: 'Duration')
    fill_in('Price', with: 'Price')
    check('Online Session')
    check('Presencial Session')
    check('Enable Course')
    fill_in('Starting from', with: '05/08/2020')
    attach_file('Course Image', "#{Rails.root}/spec/fixtures/ielts_cover_image.jpeg")
    self
  end

  def submit
    click_on('Save Course')
    self
  end
end
