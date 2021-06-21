Magicka
====
[![Code Climate](https://codeclimate.com/github/darthjee/magicka/badges/gpa.svg)](https://codeclimate.com/github/darthjee/magicka)
[![Test Coverage](https://codeclimate.com/github/darthjee/magicka/badges/coverage.svg)](https://codeclimate.com/github/darthjee/magicka/coverage)
[![Issue Count](https://codeclimate.com/github/darthjee/magicka/badges/issue_count.svg)](https://codeclimate.com/github/darthjee/magicka)
[![Gem Version](https://badge.fury.io/rb/magicka.svg)](https://badge.fury.io/rb/magicka)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/9836de08612e46b889c7978be2b72a14)](https://www.codacy.com/manual/darthjee/magicka?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=darthjee/magicka&amp;utm_campaign=Badge_Grade)
[![Inline docs](http://inch-ci.org/github/darthjee/magicka.svg?branch=master)](http://inch-ci.org/github/darthjee/magicka)

![magicka](https://raw.githubusercontent.com/darthjee/magicka/master/magicka.jpg)

Magica helps creating html templates for forms and display data using js applications
such as AngulaJS

Yard Documentation
-------------------
[https://www.rubydoc.info/gems/magicka/0.5.5](https://www.rubydoc.info/gems/magicka/0.5.5)

Installation
---------------

- Install it

```ruby
  gem install magicka
```

- Or add Magicka to your `Gemfile` and `bundle install`:

```ruby
  gem 'magicka'
```

```bash
  bundle install magicka
```

## Usage
Magicka is used as a helper for erb coding so that each element is paired with an
element class, a template and a method in an aggregator.

Different aggregators have the same method so that they render the same `element` in
different ways

### example
```html.erb
<!-- new.html.erb -->

<% magicka_form('controller.person') do |form| %>
  <%= render partial: 'person_form', locals: { form: form } %>
<% end %>
```

```html.erb
<!-- show.html.erb -->

<% magicka_display('controller.person') do |form| %>
  <%= render partial: 'person_form', locals: { form: form } %>
<% end %>
```

```html.erb
<!-- _person_form.html.erb -->

<%= form.input(:first_name) %>
<%= form.input(:last_name) %>
<%= form.input(:age) %>
<%= form.select(:gender, options: %w[MALE FEMALE] %>
<%= form.button(ng_click: 'controller.save', text: 'Save') %>
```

## Configuring
In order to use magicka, the helper has to added to the controllers and any custom
element needs to added

`app/controllers/application_controller.rb`
```ruby
class ApplicationController < ActionController::Base
  helper Magicka::Helper
end
```

### Including custom elements

Elements can be included by defining attributes that they can be initialized with
and that can be passed to the template

`config/initializers/magicka.rb`
```ruby
module Magicka
  class MyTextInput < Magicka::Element
    with_attribute_locals :label, :field, :id
  end
end

Magicka::Form.with_element(Magicka::MyTextInput)
```

`templates/form/_my_text_input.html.erb`
```html.erb
<div>
  <label for="<%= field %>"><%= label %></label>
  <input type="text" id="<%= id %>" name="field" />
</div>
```
