require 'rack'
require 'twitter'
require 'thin'
require './configure'

# encoding: utf-8

class Practica2

  def call env
    req = Rack::Request.new(env)
    res = Rack::Response.new 
    res['Content-Type'] = 'text/html'
    name = (req["firstname"] && req["firstname"] != '') ? req["firstname"] :'WaldoNazco'
    res.write <<-"EOS"
      <!DOCTYPE HTML>
      <html>
        <title>Rack::Response</title>
        <body>
          <h1>
              #{Twitter.user_timeline(name).first.text}
             <form action="/" method="post">
               Introduzca Nombre: <input type="text" name="firstname" autofocus><br>
               <input type="submit" value="Submit">
             </form>
          </h1>
        </body>
      </html>
    EOS
    res.finish
  end
end

Rack::Server.start(
  :app => Practica2.new,
  :Port => 8080,
  :server => 'thin'
)
