# Enja

[![Build Status](https://travis-ci.org/yhirano55/enja.svg?branch=master)](https://travis-ci.org/yhirano55/enja)
[![Gem Version](https://badge.fury.io/rb/enja.svg)](https://badge.fury.io/rb/enja)

Easily role definition depend on `enumerize` gem for Rails.

## Installation

```ruby
gem 'enja'
```

Optionally, you can run the generator, which will set up a role field with some useful defaults for you:

```bash
$ bin/rails g enja:install
```

## Usage

Call `define_role_method` in your resource of user model (`User`, `AdminUser` or `Member` etc):

```ruby
class User < ApplicationRecord
  define_role_method :role, in: [:guest, :staff, :admin], default: :guest
end
```

Then it provides some convenient methods for implement role based system:

```ruby
user = User.new(role: :guest)

# == Predicate Methods
user.guest? # true
user.staff? # false
user.admin? # false

# == Update Methods
user.guest! # => :guest
user.staff! # => :staff
user.admin! # => :admin

# == Scopes
User.guest.all # User.where(role: :guest).all
User.staff.all # User.where(role: :staff).all
User.admin.all # User.where(role: :admin).all
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
