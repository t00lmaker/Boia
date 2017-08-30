# Apos o bundle install, rode os seguintes comandos:
# - whenever --update-crontab (rode isso todas vez que atualizar esse arquivo)
# - whenever
# - crontab -l (verifique se o agendamento foi feito)
# Example:
#
# COMO FAZER:
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# Learn more: http://github.com/javan/whenever

set :output, "logs/cron_log.log"
#todos os dias as 15:00
every :weekday, :at => '10:40am' do
  rake "pedir_almoco"
end

#notifica todos os dias 15:10
every :weekday, :at => '10:45am' do
  rake "enviar_email"
end
