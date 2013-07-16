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

    - stable :class => 'w120', :style => "width:480px" do
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

Note: In all the examples there is a width property, but is set only for a proper displaying. This parameter is not required.

## Configuration

You can set how many rows or columns will be fixed. The others will be scrollable.
By default one row and one column will be fixed, and is the minimum required for the table to work properly.

To render a sample scrollable table with 2 fixed columns and 3 fixed headers (rows).

    - stable :class => 'w120', :fixed_columns => 2, :fixed_rows => 3, :style => "width:480px" do
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

If you choose to use the thead helper, the fixed_rows parameter will be ignored, and everything in the thead section will be fixed.
In the example, only the two rows in the thead will be fixed.

    - stable :class => 'w120', :fixed_rows => 4, :style => "width:480px" do
      - thead do
        - tr do
          - td 'L\N'
          - td 'Title 1'
          - td 'Title 2'
          - td 'Title 3'
          - td 'Title 4'
          - td 'Title 5'
        - tr do
          - td 'L\N'
          - td 'SubTitle 1'
          - td 'SubTitle 2'
          - td 'SubTitle 3'
          - td 'SubTitle 4'
          - td 'SubTitle 5'
      - ('a'..'z').each do |c|
        - tr do
          - td "Title #{c}"
          - td "#{c}1"
          - td "#{c}2"
          - td "#{c}3"
          - td "#{c}4"
          - td "#{c}5"

The helper methods 'stable', 'table', 'tr' and 'td' accept HTML parameters such as class, id, style, title...

    - stable :class => "w120 stable-class", :id => "stable-id", :style => "width:480px" do
      - thead do
        - tr :title => "First tr" do
          - td 'L\N', :class => "title"
          - td 'Title 1', :class => "title"
          - td 'Title 2', :class => "title"
          - td 'Title 3', :class => "title"
          - td 'Title 4', :class => "title"
          - td 'Title 5', :class => "title"
        - tr do
          - td 'L\N', :class => "subtitle"
          - td 'SubTitle 1', :class => "subtitle"
          - td 'SubTitle 2', :class => "subtitle"
          - td 'SubTitle 3', :class => "subtitle"
          - td 'SubTitle 4', :class => "subtitle"
          - td 'SubTitle 5', :class => "subtitle"
      - ('a'..'z').each do |c|
        - tr do
          - td "Title #{c}"
          - td "#{c}1"
          - td "#{c}2"
          - td "#{c}3"
          - td "#{c}4"
          - td "#{c}5"


You can also set an attribute on a cell (such as class) for a column. This style will be applied for this cell and all the cells below it.

    - stable class: 'w120', fixed_rows: 2 do
      - tr do
        - td 'L\N'
        - td 'Title 1'
        - td 'Title 2'
        - td 'Title 3', column: { class: 'red' }
        - td 'Title 4'
        - td 'Title 5'
        - td 'Title 6'
        - td 'Title 7'
      - ('a'..'z').each do |c|
        - tr do
          - td "Title #{c}"
          - td "#{c}1"
          - td "#{c}2"
          - td "#{c}3"
          - td "#{c}4"
          - td "#{c}5", column: { class: 'blue' }
          - td "#{c}6"
          - td "#{c}7"


## Testing
If you want to see a few working examples of the Stable, and test some of them, do the following:

    $ git clone git@github.com:manastech/stable-rails.git
    $ cd stable-rails
    $ bundle install
    $ bundle exec ruby spec/sinatra-app/app.rb

The views are in stable-rails/spec/sinatra-app/views

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
