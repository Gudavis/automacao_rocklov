Então('sou redirecionado para o Dashboard') do
  expect(page).to have_css '.dashboard'
  sleep 5 #temporarily
end

Então('vejo a mensagem de alerta: {string}') do |expect_alert|
  alert = find('.alert-dark')
  expect(alert.text).to eql expect_alert
end