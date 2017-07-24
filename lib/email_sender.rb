require 'pony'

class EmailSender

  def initialize
    @options = {
      :subject => "Apresentacao Boia",
      :body => "Olá, sou o boia.",
      :headers => { 'Content-Type' => 'text/html' },
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'contato-no-reply@infoway-pi.com.br',
        :password             => 'cnt-n0t-r3ply',
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain               => "localhost.localdomain"
      }
    }
  end


  def options()
    @options.clone
  end

  def send(to, subject, body)
    options = options()
    options[:subject] = subject
    options[:body] = body
    Pony.options = options
    Pony.mail(:to => to)
  end


end
