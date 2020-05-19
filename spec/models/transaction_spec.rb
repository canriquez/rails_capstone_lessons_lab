require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'testing validations' do
    it 'requires booking_type' do
      b = Transaction.new(booking_type: '')
      b.valid?
      expect(b.valid?).to be_falsy
    end

    it 'requires minutes' do
      b = Transaction.new(minutes: '')
      b.valid?
      expect(b.valid?).to be_falsy
    end

    it 'requires status' do
      b = Transaction.new(status: '')
      b.valid?
      expect(b.valid?).to be_falsy
    end

    it 'validates presence for billable course / billable student' do

      t = FactoryBot.create(:teacher_user) 
      c = FactoryBot.create(:group_enabled, author: t)
      
      b = Transaction.new(teacher_id: t, sitting_student_id: '', course_taught_id: '', minutes: 15, status:0, booking_type: 0)
      b.valid?
      expect(b.valid?).to be_falsy
    end
  


  end

  describe 'test associations' do
            #testing associations with shoulda matchers
            it { should belong_to(:teacher) } #against User
           
            #since course_taught and Sitting_student are optional:true
            #association validation will fail. This is compensated by the
            #special presence validation on  course_taught and Sitting_student
            #in the validation describe.
  end

  describe 'testing model scopes' do

    it 'it fetches not_billable transactions' do
      t = FactoryBot.create(:teacher_user) 
      s = FactoryBot.create(:student_user) 
      c = FactoryBot.create(:group_enabled, author: t)
      e = FactoryBot.create(:enroll, student: s, course: c)
      b = FactoryBot.create(:non_billable, sitting_student_id: s.id, course_taught_id: c.id)
      total = Transaction.not_billable.to_a
      expect(total.count).to eq(1)   

    end

    it 'it fetches transactions order by most recent' do
      t = FactoryBot.create(:teacher_user) 
      s = FactoryBot.create(:student_user) 
      c = FactoryBot.create(:group_enabled, author: t)
      e = FactoryBot.create(:enroll, student: s, course: c)
      b1 = FactoryBot.create(:non_billable, sitting_student_id: s.id, course_taught_id: c.id)
      b2 = FactoryBot.create(:non_billable, sitting_student_id: s.id, course_taught_id: c.id, minutes: 99)

      total = Transaction.not_billable.last
      expect(total.minutes).to eq(99)   

    end

  end 

  describe 'testing model instance methods' do
    it 'fetches the list of billable transactions (bookings) for a teacher' do
      t1 = FactoryBot.create(:teacher_user) 
      s1 = FactoryBot.create(:student_user) 
      c1 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)
      b1=FactoryBot.create(:billable, sitting_student_id: s1.id, course_taught_id: c1.id)
      b1=FactoryBot.create(:billable, sitting_student_id: s1.id, course_taught_id: c1.id)
      b1=FactoryBot.create(:billable, sitting_student_id: s1.id, course_taught_id: c1.id)
      total = Transaction.billable(t1).to_a
      expect(total.count).to eq(3)
    end

    it 'fetches the list of billable transactions (bookings) for a student' do
      t1 = FactoryBot.create(:teacher_user) 
      s1 = FactoryBot.create(:student_user) 
      s2 = FactoryBot.create(:student_user)
      c1 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)
      e1 = FactoryBot.create(:enroll, student: s2, course: c1)
      b1 = FactoryBot.create(:billable, sitting_student_id: s1.id, course_taught_id: c1.id)
      b2 = FactoryBot.create(:billable, sitting_student_id: s1.id, course_taught_id: c1.id)
      b3 = FactoryBot.create(:billable, sitting_student_id: s2.id, course_taught_id: c1.id)
      total = Transaction.student_billable(s1).to_a
      expect(total.count).to eq(2)
    end

  end
end
