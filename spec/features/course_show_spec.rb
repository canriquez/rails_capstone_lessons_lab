require 'rails_helper'

feature 'group/course show page' do

    scenario 'course show page' do 
        group_course = FactoryBot.create(:group, name: "Cambridge 1" )
        visit ("/groups/#{group_course.id}")
        puts "LOOK HERE FOR GROUP COURSE: #{group_course.id}"

        expect(page).to have_content('Cambridge 1')

    end


end 
