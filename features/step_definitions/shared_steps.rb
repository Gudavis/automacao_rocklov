Então('sou redirecionado para o Dashboard') do
  expect(@dashboard.on_dashboard?).to be true
end

Então('vejo a mensagem de alerta: {string}') do |expect_alert|
  expect(@alert.message).to eql expect_alert
end