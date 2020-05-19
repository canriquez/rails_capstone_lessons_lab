require 'rails_helper'

RSpec.describe Enroll, type: :model do
  describe 'validations' do
        
    it 'requires student' do
        t1 = FactoryBot.create(:teacher_user) 
        s1 = FactoryBot.create(:student_user) 
        c1 = FactoryBot.create(:group_enabled, author: t1)
        enroll = Enroll.new(student: nil, course:c1)
        enroll.valid?
        expect(enroll.valid?).to be_falsy
    end

    it 'requires course' do
        t1 = FactoryBot.create(:teacher_user) 
        s1 = FactoryBot.create(:student_user) 
        c1 = FactoryBot.create(:group_enabled, author: t1)
        enroll = Enroll.new(student: s1, course: nil)
        enroll.valid?
        expect(enroll.valid?).to be_falsy
    end

  end

  describe 'test associations' do
    #testing associations with shoulda matchers
    it { should belong_to(:student) } #against User
    it { should belong_to(:course) } #against Group
  end

  describe 'test instance methods' do
    it 'fech current enroll count for student/course pair' do
      t1 = FactoryBot.create(:teacher_user) 
      s1 = FactoryBot.create(:student_user) 
      c1 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)
      total = Enroll.already_enrolled(s1, c1)
      expect(total).to eq(1)
    end

    it 'fech current missing enroll for student/course pair' do
      t1 = FactoryBot.create(:teacher_user) 
      s1 = FactoryBot.create(:student_user) 
      c1 = FactoryBot.create(:group_enabled, author: t1)
      total = Enroll.already_enrolled(s1, c1)
      expect(total).to eq(0)
    end
  end
end
