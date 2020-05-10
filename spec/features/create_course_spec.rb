require 'rails_helper'
require_relative '../support/new_group_form_handler'

feature 'create new group/course' do
  let(:new_group_form) { NewGroupForm.new }

  scenario 'create course with valid data' do
    new_group_form.visit_page.fill_in_with(
      'name': 'Cambridge C1'
    ).submit
    expect(page).to have_content('Course has been created')
    expect(Group.last.name).to eq('Cambridge C1')
  end

  scenario 'failing to create achievement with invalid data' do
    new_group_form.visit_page.fill_in_with(
      name: nil
    ).submit

    expect(page).to have_content("can't be blank")
  end
end
