class Alert
  include Capybara::DSL

  def message
    return find('.alert-dark').text
  end
end