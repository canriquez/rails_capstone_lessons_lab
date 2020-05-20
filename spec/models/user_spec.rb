# rubocop:disable Lint/UselessAssignment
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires name' do
      user = User.new(name: '')
      user.valid?
      expect(user.valid?).to be_falsy
    end

    it 'requires role' do
      user = User.new(role: '')
      user.valid?
      expect(user.valid?).to be_falsy
    end

    it 'requires email' do
      user = User.new(email: '')
      user.valid?
      expect(user.valid?).to be_falsy
    end

    it 'requires valid email' do
      user = User.new(email: 'dasdasd')
      user.valid?
      expect(user.valid?).to be_falsy
    end

    it 'has many enrolled courses' do
      t1 = FactoryBot.create(:teacher_user)
      s1 = FactoryBot.create(:student_user)
      c1 = FactoryBot.create(:group_enabled, author: t1)
      c2 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)
      e2 = FactoryBot.create(:enroll, student: s1, course: c2)
      expect(e2.valid?).to_not be_falsy
    end

    it 'has many authored groups (courses)' do
      t1 = FactoryBot.create(:teacher_user)
      c1 = FactoryBot.create(:group_enabled, author: t1)
      c2 = FactoryBot.create(:group_enabled, author: t1)
      expect(c2.valid?).to_not be_falsy
    end

    it 'has many transactions ( taught sessions - bookings)' do
      t1 = FactoryBot.create(:teacher_user)
      s1 = FactoryBot.create(:student_user)
      c1 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)

      b1 = FactoryBot.create(:billable, sitting_student: s1, course_taught: c1, teacher: t1)
      b2 = FactoryBot.create(:billable, sitting_student: s1, course_taught: c1, teacher: t1)
      expect(b2.valid?).to_not be_falsy
    end
  end

  describe 'testing associations using shoulda-matchers' do
    # testing associations with shoulda matchers
    it { should have_many(:authored_courses) } # against Group
    it { should have_many(:taught_sessions) } # against Transactions
    it { should have_many(:enrolled_courses) } # against Enroll
    it { should have_many(:my_courses) } # against Transactions
  end

  describe 'testing model instance enum and  methods ' do
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

    it 'capitlizes names before saving' do
      t1 = FactoryBot.create(:teacher_user, name: 'pedro')
      puts t1.name
      expect(t1.name).to eq('Pedro')
    end

    it 'responds true if user enrolled in a course' do
      t1 = FactoryBot.create(:teacher_user)
      s1 = FactoryBot.create(:student_user)
      c1 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)

      expect(s1.enrolled(c1)).to be_truthy
    end

    it 'fetches the list of users enrolled in one course' do
      t1 = FactoryBot.create(:teacher_user)
      s1 = FactoryBot.create(:student_user)
      s2 = FactoryBot.create(:student_user)
      c1 = FactoryBot.create(:group_enabled, author: t1)
      c2 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)
      e2 = FactoryBot.create(:enroll, student: s2, course: c1)
      total = User.enrolled_list(c1).to_a
      expect(total.count).to eq(2)
    end

    it 'fetches the list of users available for enroll to a couese' do
      t1 = FactoryBot.create(:teacher_user)
      s1 = FactoryBot.create(:student_user)
      s2 = FactoryBot.create(:student_user)
      s3 = FactoryBot.create(:student_user)
      c1 = FactoryBot.create(:group_enabled, author: t1)
      e1 = FactoryBot.create(:enroll, student: s1, course: c1)
      total = User.to_enroll(c1).to_a
      total.each { |x| puts x.id }
      enroll_list = Enroll.all.to_a
      enroll_list.each { |x| puts x.student_id }
      expect(total.count).to eq(2)
    end
  end
end

# rubocop:enable Lint/UselessAssignment
