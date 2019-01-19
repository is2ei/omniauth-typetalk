omniauth-typetalk
===

[![Build Status](https://travis-ci.org/is2ei/omniauth-typetalk.svg?branch=master)][travis]

[travis]: https://travis-ci.org/is2ei/omniauth-typetalk

Typetalk OAuth2 Strategy for OmniAuth

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :typetalk, ENV['TYPETALK_KEY'], ENV['TYPETALK_SECRET']
end 
```

## Sinatra Example

```ruby
require 'sinatra'
require 'omniauth'
require 'omniauth-typetalk'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :typetalk, ENV['TYPETALK_KEY'], ENV['TYPETALK_SECRET'], scope: "my topic.read"
end

get '/' do
  <<-HTML
  <a href='/auth/typetalk'>Sign in with Typetalk</a>
  HTML
end

get '/auth/:name/callback' do
  auth = request.env['omniauth.auth']

  <<-HTML
  <p>[Profile]</p>
  <p>id: #{auth.info.id}</p>
  <p>name: #{auth.info.name}</p>
  <p>fullName: #{auth.info.fullName}</p>
  <p>suggestion: #{auth.info.suggestion}</p>
  <p>imageUrl: #{auth.info.imageUrl}</p>
  <p>createdAt: #{auth.info.createdAt}</p>
  HTML
end
```