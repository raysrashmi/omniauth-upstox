# OmniAuth Upstox Strategy

[![Gem Version](https://badge.fury.io/rb/omniauth-upstox.svg)](https://rubygems.org/gems/omniauth-upstox)
[![Build Status](https://github.com/raysrashmi/omniauth-upstox/actions/workflows/test.yml/badge.svg)](https://github.com/raysrashmi/omniauth-upstox/actions)

This gem provides an [OmniAuth](https://github.com/omniauth/omniauth) strategy for authenticating with [Upstox](https://upstox.com) using OAuth2. It allows your Ruby on Rails or Rack-based application to interact with Upstox's APIs for authentication.
To use it, you'll need to sign up for an OAuth2 Client ID and Client Secret
on the

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-upstox'


## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :upstox, ENV['UPSTOX_CLIENT_ID'], ENV['UPSTOX_CLIENT_SECRET'], redirect_uri: 'http://localhost:3001/auth/upstox/callback'
end
```


## Basic Usage Rails

In `config/initializers/omniauth.rb`

```ruby
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :upstox, ENV['UPSTOX_CLIENT_ID'], ENV['UPSTOX_CLIENT_SECRET'], redirect_uri: 'http://localhost:3001/auth/upstox/callback'
  end
```

## License

Copyright (c) 2011 by Rashmi Yadav

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
