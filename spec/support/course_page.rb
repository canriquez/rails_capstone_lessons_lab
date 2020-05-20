class MyCoursePage
  include Capybara::DSL

  def visit_page
    visit('/groups')
    self
  end

  def new_course
    click_on('Add New Course')
    self
  end

  def edit_course
    find(:css, '.edit-test').click
    self
  end

  def student_hack_into_new_group_page
    visit('/groups/new')
    self
  end

  def select_student_to_enroll
    find('.custom-select').trigger(:click)
    all(:css, '.enroll')[0].select('student-99')
    click_on('edit')
    self
  end
end
