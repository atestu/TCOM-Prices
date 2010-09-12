require 'rubygems'
require 'sinatra'
require 'hpricot'
require 'open-uri'
require 'haml'

get '/' do
  docEuro = open("http://www.boursorama.com/cours.phtml?symbole=1xEURUS") { |f| Hpricot(f) }
  docGold = open("http://www.boursorama.com/cours.phtml?symbole=1xGLDAM") { |f| Hpricot(f) }
  docOil = open("http://www.boursorama.com/cours.phtml?symbole=CLOC10") { |f| Hpricot(f) }
  @euro = (docEuro/"#cours_Header_0 div.body div.FVHead div.FVInfB div.InfB span.gras").first.inner_html.to_f
  @gold = (docGold/"#cours_Header_0 div.body div.FVHead div.FVInfB div.InfB span.gras").first.inner_html.gsub(/ /,"").to_i
  @oil = (docOil/"#cours_Header_0 div.body div.FVHead div.FVInfB div.InfB span.gras").first.inner_html.to_f
  haml :index
end
