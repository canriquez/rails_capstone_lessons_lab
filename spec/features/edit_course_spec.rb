require 'rails_helper'
require_relative '../support/edit_group_form_handler'

feature 'Edit existing and enabled group/course' do
=begin   
  let(:edit_group_form) { EditGroupForm.new }
  let(:enabled_group_course) { FactoryBot.create(:group_enabled) }

  scenario 'edit course with valid data' do
    edit_group_form.visit_page.fill_in_with(
      'name': 'Cambridge C2 edition'
    ).submit
    expect(page).to have_content('Course has been updated correctly')
    expect(Group.last.name).to eq('Cambridge C2 edition')
  end 
=end

=begin   
scenario 'failing to edit achievement with invalid data' do
    edit_group_form.visit_page.fill_in_with(
      name: nil
    ).submit

    expect(page).to have_content("can't be blank")
  end 
=end


end
