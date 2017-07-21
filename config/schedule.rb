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
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "logs/cron_log.log"
#todos os dias as 16:30
every '30 15 * * *' do
  rake "pedir_almoco"
end
