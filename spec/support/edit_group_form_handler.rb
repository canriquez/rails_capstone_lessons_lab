class EditGroupForm
    include Capybara::DSL
  
    def visit_page
      visit('/groups')
      click_on('Edit Course')
      self # so we can chain our mesagges
    end
  
    def fill_in_with(params = {})
      fill_in('Course Name', with: params.fetch(:name, 'Course Name Change'))
      self
    end
  
    def submit
      click_on('Update Course')
      self
    end
  end
  