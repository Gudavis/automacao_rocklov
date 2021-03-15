Before do
  @alert = Alert.new
  @login = LoginPage.new
  @signup = SignupPage.new
  @dashboard = DashboardPage.new
  @equipos = EquiposPage.new

  page.current_window.resize_to(1440, 900)
end

After do
  temp_screenshot = page.save_screenshot("logs/temp_screenshot.png")

  Allure.add_attachment(
    name: "Screenshot",
    type: Allure::ContentType::PNG,
    source: File.open(temp_screenshot),
  )
end
