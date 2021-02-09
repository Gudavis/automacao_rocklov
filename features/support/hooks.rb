Before do
  @alert = Alert.new
  @login = LoginPage.new
  @signup = SignupPage.new
  @dashboard = DashboardPage.new
  @equipos = EquiposPage.new

  page.current_window.resize_to(1440, 900)
end
