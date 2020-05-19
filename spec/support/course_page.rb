class MyCoursePage
    include Capybara::DSL 


    def visit_page
        visit("/groups")
        self
    end

    def new_course
        click_on("Add New Course")
        self
    end

    def student_hack_into_new_group_page
        visit("/groups/new")
        self
    end

end
