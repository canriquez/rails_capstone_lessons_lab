require 'rails_helper'
require_relative '../support/new_transaction_form_handler'

feature 'create new transaction/booking' do
  let(:new_transaction_form) { NewTransactionForm.new }

  scenario 'create transaction with valid data' do
    new_transaction_form.visit_page.fill_in_with(
      'course': 'Cambridge C1', 'student': 'student-1', 'minutes': 45
    ).submit
    expect(page).to have_content('Cambridge C1')
    expect(Transaction.last.course_taught_id).to eq(course_tought.id)
    expect(Group.last.status).to eq(:generated)
  end

  scenario 'failing to create achievement with invalid data' do
    new_transaction_form.visit_page.fill_in_with(
      'course': nil
    ).submit

    expect(page).to have_content("can't be blank")
  end
end
