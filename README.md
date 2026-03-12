Magicka
====
[![CircleCI](https://dl.circleci.com/status-badge/img/gh/darthjee/magicka/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/darthjee/magicka/tree/main)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/f0d549e6d2ed47c5b1c5451bcb250ff2)](https://app.codacy.com/gh/darthjee/magicka/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![Codacy Badge](https://app.codacy.com/project/badge/Coverage/f0d549e6d2ed47c5b1c5451bcb250ff2)](https://app.codacy.com/gh/darthjee/magicka/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_coverage)
[![Gem Version](https://badge.fury.io/rb/magicka.svg)](https://badge.fury.io/rb/magicka)
[![Inline docs](http://inch-ci.org/github/darthjee/magicka.svg?branch=master)](http://inch-ci.org/github/darthjee/magicka)

![magicka](https://raw.githubusercontent.com/darthjee/magicka/master/magicka.jpg)

Magica helps creating html templates for forms and display data using js applications
such as AngulaJS

**Current Release**: [1.2.0](https://github.com/darthjee/magicka/tree/1.2.0)

**Next release**: [1.3.0](https://github.com/darthjee/magicka/compare/1.2.0...main)

Yard Documentation
-------------------
[https://www.rubydoc.info/gems/magicka/1.2.0](https://www.rubydoc.info/gems/magicka/1.2.0)

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

<%= form.only(:form) do %>
  <!-- this block only appears in a form -->
  <%= form.button(ng_click: 'controller.save', text: 'Save') %>
<% end %>
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
