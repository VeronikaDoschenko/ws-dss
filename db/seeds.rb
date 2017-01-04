# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

code = <<-EOS
    # This is test method for ws-dss
    # Author: Vladimir Sudakov (c) 2015
    
    require 'json'
    my_data = $stdin.read
    puts "-------------------------------------------------------------"
    puts "Input Data:"
    puts my_data
    puts
    
    h = JSON.parse(my_data)
    
    puts "-------------------------------------------------------------"
    puts "Everythin is OK!"
    puts h
EOS

test_input = <<-EOS
    {  
    "criterions": [
      {"name":"Научный эффект", "scale": ["н/у", "неуд",	"уд",	"хор", "отл"], "rank": 0.19697},
      {"name":"Прикладной эффект", "scale": [98,	155, 173, 256], "rank": 0.19697, "min":0}
      ]
    }
EOS

test_output = <<-EOS
    -------------------------------------------------------------
    Input Data:
    {  
    "criterions": [
      {"name":"Научный эффект", "scale": ["н/у",	"неуд",	"уд",	"хор", "отл"], "rank": 0.19697},
      {"name":"Прикладной эффект", "scale": [98,	155, 173, 256], "rank": 0.19697, "min":0}
      ]
    }
    
    -------------------------------------------------------------
    Everythin is OK!
    {"criterions"=>[{"name"=>"Научный эффект", "scale"=>["н/у", "неуд", "уд", "хор", "отл"], "rank"=>0.19697},
    {"name"=>"Прикладной эффект", "scale"=>[98, 155, 173, 256], "rank"=>0.19697, "min"=>0}]}
EOS

if WsMethod.find_by_name('DummyMethod').nil?
  WsMethod.create( {:name => 'DummyMethod',
                    :code => code,
                    :test_input => test_input,
                    :test_output => test_output})
end

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed
