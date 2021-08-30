require 'sinatra'
# require reloader gem
require 'sinatra/reloader'

get '/shops/:shop_id/redirects' do
  if params[:shop_id].to_i.even?
    [
      {
        "id": 1,
        "path": '/',
        "regex": true,
        "protocol_policy": 'http',
        "behavior": 'redirect',
        "redirect_to": '/home'
      },
      {
        "id": 2,
        "path": '\\.(jpg|jpeg|gif|png)$',
        "regex": true,
        "protocol_policy": 'http',
        "behavior": 'redirect',
        "redirect_to": '/imagens'
      }
    ].to_json
  else
    [
      {
        "id": 1,
        "path": '/test123',
        "regex": true,
        "protocol_policy": 'http',
        "behavior": 'redirect',
        "redirect_to": '/home'
      },
      {
        "id": 2,
        "path": '\\.(jpg|jpeg|gif|png)$',
        "regex": true,
        "protocol_policy": 'http',
        "behavior": 'redirect',
        "redirect_to": '/imagens'
      }
    ].to_json
  end
end

post '/shops/:shop_id/redirects' do
  chance_of_success = rand(20)
  if chance_of_success > 1
    status 201
    body({
      "id": rand(1000),
      "path": '/',
      "regex": true,
      "protocol_policy": 'http',
      "behavior": 'redirect',
      "redirect_to": '/home'
    }.to_json)
  else
    status 400
    body 'bad luck'
  end
end

patch '/shops/:shop_id/redirects/:id' do
  chance_of_success = rand(10)
  if chance_of_success > 1
    status 200
  else
    status 400
    body 'bad_luck'
  end
end

delete '/shops/:shop_id/redirects/:id' do
  pp params
  chance_of_success = rand(10)
  if chance_of_success > 1
    status 204
  else
    status 400
    body 'bad luck'
  end
end

get '/' do
  'Hello world!'
end
