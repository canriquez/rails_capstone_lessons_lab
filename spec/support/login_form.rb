class LoginForm
  include Capybara::DSL

  def visit_page
    visit('/users/sign_in')
    self
  end

  def login_as(user)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    self
  end

  def submit
    click_on('Log in')
  end
end
