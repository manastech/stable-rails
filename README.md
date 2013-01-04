# Stable::Rails

Scrollable table with fixed first row and column.

## Installation

Add this line to your application's Gemfile:

    gem 'stable-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stable-rails

## Usage

In application.js include

    //= require stable

In application.css include

    *= require stable

To render a sample scrollable table

    - stable do
      - tr do
        - td 'L\N'
        - td 'Title 1'
        - td 'Title 2'
        - td 'Title 3'
        - td 'Title 4'
        - td 'Title 5'
      - ('a'..'z').each do |c|
        - tr do
          - td "Title #{c}"
          - td "#{c}1"
          - td "#{c}2"
          - td "#{c}3"
          - td "#{c}4"
          - td "#{c}5"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
