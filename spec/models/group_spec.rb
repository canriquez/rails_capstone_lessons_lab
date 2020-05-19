require 'rails_helper'
RSpec.describe Group, type: :model do


  describe 'testing validations' do
    it 'requires name' do
      group = Group.new(name: '')
      group.valid?
      expect(group.valid?).to be_falsy
    end

    it 'requires description' do
      group = Group.new(description: '')
      group.valid?
      expect(group.valid?).to be_falsy
    end

    it 'requires duration' do
      group = Group.new(duration: '')
      group.valid?
      expect(group.valid?).to be_falsy
    end

    it 'requires price' do
      group = Group.new(price: '')
      group.valid?
      expect(group.valid?).to be_falsy
    end

    it 'requires starting' do
      group = Group.new(starting: '')
      group.valid?
      expect(group.valid?).to be_falsy
    end

    it 'requires cover_image' do
      group = Group.new(cover_image: '')
      group.valid?
      expect(group.valid?).to be_falsy
    end
  end

  
  describe 'testing association ' do
    it { should belong_to(:author) } #against User
    it { should have_many(:booked_sessions) } #against Transaction
    it { should have_many(:enrolled) } #through Transaction against Users (enrolled_students)
    it { should have_many(:enrollments) } #against Enroll
  end

  describe 'testing instance methods' do

    it 'it provides the list of users role: teacher' do
      t1 = FactoryBot.create(:teacher_user) 
      total = User.teacher.to_a
      expect(total.count).to eq(1)
    end

    it 'it provides the list of users role: student' do
      t1 = FactoryBot.create(:student_user) 
      total = User.teacher.to_a
      expect(total.count).to_not eq(1)
    end

    it 'returns users within the enrolled scope in groups (courses) ' do
      t1 = FactoryBot.create(:teacher_user) 
      s1 = FactoryBot.create(:student_user) 
      c1 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)
      total = Group.enrolled_courses(s1).to_a
      expect(total.count).to eq(1)
    end

    it 'returns users within the author scope with group authored (group/courses) ' do
      t1 = FactoryBot.create(:teacher_user) 
      t2 = FactoryBot.create(:teacher_user) 
      c1 = FactoryBot.create(:group_enabled, author: t1)
      c1 = FactoryBot.create(:group_enabled, author: t2)
      total = Group.authored_courses(t1).to_a
      expect(total.count).to eq(1)
    end





  end


end
