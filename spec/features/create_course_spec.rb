require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/course_page'
require_relative '../support/new_course_form'

feature 'create new group/course' do
  let(:t1) { FactoryBot.create(:teacher_user) }
  let(:s1) { FactoryBot.create(:student_user) }
  let(:login_form) { LoginForm.new }
  let(:manage_my_course_page) { MyCoursePage.new }
  let(:new_course_form) { CourseForm.new }

  scenario 'authenticated and authorise user (Teacher) create course with valid data' do
    login_form.visit_page.login_as(t1).submit


    puts t1.email
    puts t1.password
    puts t1.role
    #expect(page).to have_content('teacher')

    manage_my_course_page.visit_page.new_course
    
    new_course_form.fill_form.submit
    
    expect(page).to have_content('IELTS')
    expect(page).to have_css("span#test-course", text: '1')
    expect(Group.last.enabled).to eq(true)
  
  end

  scenario 'Student fails to create a new course' do
    login_form.visit_page.login_as(s1).submit


    puts s1.email
    puts s1.password
    puts s1.role


    manage_my_course_page.student_hack_into_new_group_page
    
    #new_course_form.fill_form.submit
    
    expect(page).to have_content('you are not authorised for this action')

  end
end
