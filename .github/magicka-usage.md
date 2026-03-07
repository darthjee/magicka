# Magicka Usage Guide

Magicka is a Ruby gem that enables template reuse for both forms and data display in
Rails applications. Its main benefit is eliminating HTML duplication by allowing a
single partial to work in both form creation and data display contexts.

## Basic Setup

```ruby
# Gemfile
gem 'magicka'
```

```bash
bundle install
```

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper Magicka::Helper
end
```

## Core Concepts

### Aggregators

Magicka provides two aggregators that share the same interface but render elements
differently based on context:

- **`magicka_form`** — renders elements as interactive form inputs
- **`magicka_display`** — renders elements as read-only display values

Both aggregators expose the same methods (`input`, `select`, `button`, `only`,
`except`, `with_model`), so a single partial can be passed to either without
modification.

## Basic Usage Pattern

Define one shared partial that works for both contexts:

**Form view (`new.html.erb` or `edit.html.erb`):**
```erb
<% magicka_form('controller.person') do |form| %>
  <%= render partial: 'person_form', locals: { form: form } %>
<% end %>
```

**Display view (`show.html.erb`):**
```erb
<% magicka_display('controller.person') do |form| %>
  <%= render partial: 'person_form', locals: { form: form } %>
<% end %>
```

**Shared partial (`_person_form.html.erb`):**
```erb
<%= form.input(:first_name) %>
<%= form.input(:last_name) %>
<%= form.input(:age) %>
<%= form.select(:gender, options: %w[MALE FEMALE]) %>

<%= form.only(:form) do %>
  <!-- This block only appears in a form, not in display mode -->
  <%= form.button(ng_click: 'controller.save', text: 'Save') %>
<% end %>
```

## Available Methods

### Input Fields

```erb
<%# Renders a text input (form) or the field's display value (display) %>
<%= form.input(:field_name) %>

<%# With a custom label %>
<%= form.input(:field_name, label: 'Custom Label') %>

<%# With a placeholder %>
<%= form.input(:field_name, placeholder: 'Enter value...') %>
```

### Select / Dropdown

```erb
<%# Renders a <select> element (form) or the selected value (display) %>
<%= form.select(:field_name, options: %w[option_a option_b option_c]) %>

<%# With a custom label %>
<%= form.select(:role, label: 'User Role', options: %w[admin user guest]) %>
```

### Button

```erb
<%# Renders a button (form only — becomes a noop in display context) %>
<%= form.button(text: 'Save', ng_click: 'controller.save') %>

<%# With a disabled condition %>
<%= form.button(text: 'Save', ng_click: 'controller.save', ng_disabled: 'controller.saving') %>
```

`form.button` is automatically a no-op in display context, so it is safe to call it
outside of an `only(:form)` block when you do not need other conditional logic around
it.

### Nested Model Scope

```erb
<%# Scope a block of fields to a nested model %>
<%= form.with_model(:address) do |address_form| %>
  <%= address_form.input(:street) %>
  <%= address_form.input(:city) %>
  <%= address_form.input(:zip_code) %>
<% end %>
```

## Conditional Rendering

Use `only` and `except` to render content selectively based on the current context.

```erb
<%# Only in form context %>
<%= form.only(:form) do %>
  <%= form.button(ng_click: 'controller.save', text: 'Save') %>
<% end %>
```

```erb
<%# Only in display context %>
<%= form.only(:display) do %>
  <div class="timestamps">
    Created at: <%= @person.created_at %>
  </div>
<% end %>
```

```erb
<%# Everything except form context (equivalent to only(:display) when there are two contexts) %>
<%= form.except(:form) do %>
  <p class="read-only-note">This record is read-only.</p>
<% end %>
```

## Best Practices

- **Single Partial Pattern**: Always create one partial that works for both form and
  display contexts. Name it descriptively (e.g., `_person_form.html.erb`).
- **Context Parameter Naming**: Use `form` as the local variable name even in display
  contexts — this keeps partial signatures consistent.
- **Template Organization**: Keep partials DRY by relying on Magicka's dual-context
  rendering rather than duplicating markup.
- **Conditional Content**: Use `form.only(:form)` for submit buttons and other
  form-only elements; use `form.only(:display)` for read-only annotations.
- **Model Binding**: Pass the AngularJS model path (e.g., `'controller.person'`) as
  the first argument to `magicka_form` and `magicka_display`.
- **Labels**: Labels default to the capitalized, underscore-stripped field name
  (e.g., `:first_name` → `'First name'`). Override with `label:` when needed.

## Common Patterns

### Simple CRUD Form

```erb
<%# _user_form.html.erb %>
<%= form.input(:name) %>
<%= form.input(:email) %>
<%= form.input(:phone, label: 'Phone Number') %>
<%= form.select(:role, options: %w[admin user guest]) %>

<%= form.only(:form) do %>
  <%= form.button(text: 'Save User', ng_click: 'controller.save') %>
<% end %>
```

### Nested Attributes

```erb
<%# _company_form.html.erb %>
<%= form.input(:name, label: 'Company Name') %>

<%= form.with_model(:address) do |address_form| %>
  <%= address_form.input(:street) %>
  <%= address_form.input(:city) %>
  <%= address_form.input(:country) %>
<% end %>
```

### Combining Conditional Blocks

```erb
<%= form.input(:title) %>
<%= form.input(:body) %>

<%= form.only(:form) do %>
  <%= form.select(:status, options: %w[draft published archived]) %>
  <%= form.button(text: 'Publish', ng_click: 'controller.publish') %>
<% end %>

<%= form.only(:display) do %>
  <p>Status: <%= @article.status %></p>
  <p>Last updated: <%= @article.updated_at %></p>
<% end %>
```

## Integration with AngularJS

Magicka was designed with AngularJS in mind. The `ng_model` and `ng_errors` locals are
generated automatically for each form element based on the aggregator's model path and
the field name.

### Automatic AngularJS Bindings

Given `magicka_form('controller.person')` and `form.input(:first_name)`, Magicka
automatically makes these locals available to the element template:

| Local | Generated value |
|-------|----------------|
| `ng_model` | `"controller.person.first_name"` |
| `ng_errors` | `"controller.person.errors.first_name"` |

### Button Attributes

```erb
<%= form.button(
  text: 'Save',
  ng_click: 'controller.save()',
  ng_disabled: 'controller.form.$invalid'
) %>
```

### Example AngularJS Controller Pattern

```erb
<%# new.html.erb %>
<div ng-controller="PersonController as controller">
  <% magicka_form('controller.person') do |form| %>
    <%= render partial: 'person_form', locals: { form: form } %>
  <% end %>
</div>
```

```erb
<%# show.html.erb %>
<div ng-controller="PersonController as controller">
  <% magicka_display('controller.person') do |form| %>
    <%= render partial: 'person_form', locals: { form: form } %>
  <% end %>
</div>
```

## Custom Elements

You can extend Magicka with custom element types that integrate with both aggregators.

```ruby
# config/initializers/magicka.rb
module Magicka
  class DatePicker < Magicka::Element
    with_attribute_locals :label, :field, :min_date, :max_date
    template_folder 'templates/form'
  end
end

Magicka::Form.with_element(Magicka::DatePicker)
Magicka::Display.with_element(Magicka::DatePicker)
```

```erb
<%# templates/form/_date_picker.html.erb %>
<div class="date-picker">
  <label for="<%= field %>"><%= label %></label>
  <input type="date"
         id="<%= field %>"
         name="<%= field %>"
         min="<%= min_date %>"
         max="<%= max_date %>" />
</div>
```

```erb
<%# Use in a shared partial %>
<%= form.date_picker(:birth_date, min_date: '1900-01-01', max_date: '2099-12-31') %>
```

## Real-World Examples

The following projects use Magicka and demonstrate practical integration patterns:

- **[darthjee/oak](https://github.com/darthjee/oak)** — authentication and
  authorization patterns with Magicka forms
- **[darthjee/plague_inc](https://github.com/darthjee/plague_inc)** — game-specific
  forms and display views
- **[darthjee/paperboy](https://github.com/darthjee/paperboy)** — content management
  forms with edit/view modes

## Common Use Cases

- **User registration and profile display** — same partial for sign-up form and profile page
- **Admin panels** — identical partial switches between edit mode and read-only view
- **Data entry with preview** — form and display side by side using the same partial
- **Multi-step forms with review** — final step renders the same partial in display mode
- **API-backed forms** — display context shows persisted values; form context allows editing

## Tips for GitHub Copilot

- When creating a form, always plan the display view at the same time and write a single
  shared partial.
- Create the shared partial (`_<resource>_form.html.erb`) before writing the form and
  display views.
- Always name the block variable `form` in both `magicka_form` and `magicka_display`
  for consistency across partials.
- Use `form.only(:form)` to wrap submit buttons so they do not appear in display mode.
- Prefer `form.button(...)` over raw `<button>` tags — it automatically becomes a
  no-op in display context.
- Use `form.with_model(:nested_model)` instead of changing the parent aggregator's
  model for nested resource sections.
- Lean on automatic label derivation (`:first_name` → `'First name'`) and only supply
  an explicit `label:` when the default is not descriptive enough.
