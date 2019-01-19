omniauth-typetalk
===

Typetalk OAuth2 Strategy for OmniAuth

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :typetalk, ENV['TYPETALK_KEY'], ENV['TYPETALK_SECRET']
end 
```
