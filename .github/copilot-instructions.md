# GitHub Copilot Instructions for Magicka

## Project Overview

Magicka is a Ruby gem that facilitates the creation of HTML templates for forms and
displaying data, especially when working with JS applications like AngularJS. Its main
feature is providing a unified way to create form inputs and data display elements using
the same partial templates, avoiding HTML repetition by defining templates once and
reusing them for both forms and display views.

### How It Works

- Uses aggregators like `magicka_form` and `magicka_display` that render the same
  elements differently
- A single partial can be used for both creating forms (`new.html.erb`) and displaying
  data (`show.html.erb`)
- Each element is paired with an element class, a template, and a method in an aggregator
- Supports conditional rendering (e.g., `form.only(:form)` for form-specific content)

### Real-World Usage

The gem is used in several projects that demonstrate practical implementation patterns
and best practices:

- darthjee/oak
- darthjee/plague_inc
- darthjee/paperboy

---

## Language Requirements

- All pull requests, comments, documentation, and code must be written in **English**
- Maintain consistency in terminology and naming conventions across the codebase

---

## Testing Requirements

- Tests are **mandatory** for all code changes
- Files without tests should be included in `check_specs.yml`
- Ensure comprehensive test coverage for new features and changes
- Test both form and display rendering scenarios
- Test template generation and element rendering

---

## Documentation Requirements

- Use **YARD** format for all documentation
- Document all public methods, classes, and modules
- Include examples showing both `magicka_form` and `magicka_display` usage
- Document template creation and customization options
- Provide clear examples of element classes and aggregators

---

## Code Style and Design Principles

- Follow Sandi Metz principles from *99 Bottles of OOP*
- Keep classes and methods focused with **single responsibilities**
- Avoid violations of the **Law of Demeter**
- Prefer small, well-defined methods over large, complex ones
- Aim for **high cohesion and low coupling**
- Separate concerns: element classes, templates, and aggregators should have distinct
  responsibilities

---

## Project-Specific Guidelines

### Template Design

- Keep templates **DRY** (Don't Repeat Yourself)
- A single partial should work for both form and display contexts
- Use aggregator methods to handle context-specific rendering
- Minimize HTML duplication by leveraging the template system

### Element Classes

- Each form element should have a corresponding element class
- Element classes should encapsulate rendering logic
- Keep element classes small and focused

### Aggregators

- Different aggregators (form vs display) should share method signatures
- Aggregators should handle the context (form vs display) transparently
- Support conditional rendering for context-specific content

### Best Practices

- When adding new element types, ensure they work in both form and display contexts
- Test template rendering in multiple scenarios
- Consider AngularJS integration patterns when applicable
- Follow Rails conventions and best practices
- Maintain backward compatibility when making changes

---

## Implementation Pattern

When implementing new features, follow this pattern:

```ruby
# 1. Element class with single responsibility
module Magicka
  class MyElement < Magicka::Element
    with_attribute_locals :label, :field, :id
  end
end

# 2. Register the element with both Form and Display aggregators
Magicka::Form.with_element(Magicka::MyElement)
Magicka::Display.with_element(Magicka::MyElement)
```

```erb
<%# 3. Template for rendering (templates/form/_my_element.html.erb) %>
<div>
  <label for="<%= field %>"><%= label %></label>
  <input type="text" id="<%= id %>" name="<%= field %>" />
</div>
```

```ruby
# 4. Tests for both form and display contexts
RSpec.describe Magicka::MyElement do
  it 'renders in form context' do
    # ...
  end

  it 'renders in display context' do
    # ...
  end
end
```

```ruby
# 5. YARD documentation with examples
# @example Using in a form partial
#   <%= form.my_element(:field_name) %>
#
# @example Using in a display partial
#   <%= display.my_element(:field_name) %>
```

---

## Usage Examples

### Basic Setup

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper Magicka::Helper
end
```

### Shared Partial

```erb
<%# app/views/people/_person_form.html.erb %>
<%= form.input(:first_name) %>
<%= form.input(:last_name) %>
<%= form.input(:age) %>
<%= form.select(:gender, options: %w[MALE FEMALE]) %>

<%= form.only(:form) do %>
  <%# This block only appears in a form context %>
  <%= form.button(ng_click: 'controller.save', text: 'Save') %>
<% end %>
```

### Form View

```erb
<%# app/views/people/new.html.erb %>
<% magicka_form('controller.person') do |form| %>
  <%= render partial: 'person_form', locals: { form: form } %>
<% end %>
```

### Display View

```erb
<%# app/views/people/show.html.erb %>
<% magicka_display('controller.person') do |form| %>
  <%= render partial: 'person_form', locals: { form: form } %>
<% end %>
```

### Custom Element

```ruby
# config/initializers/magicka.rb
module Magicka
  class MyTextInput < Magicka::Element
    with_attribute_locals :label, :field, :id
  end
end

Magicka::Form.with_element(Magicka::MyTextInput)
```

```erb
<%# templates/form/_my_text_input.html.erb %>
<div>
  <label for="<%= field %>"><%= label %></label>
  <input type="text" id="<%= id %>" name="<%= field %>" />
</div>
```

## Sinclair Usage

Magicka uses the **sinclair** gem extensively. Refer to [.github/sinclair-usage.md](.github/sinclair-usage.md) for the full usage guide.

Key features used in this project:

- **`Sinclair`** – Dynamically add instance/class methods to existing classes via builders
- **`Sinclair::Model`** – Quick plain-Ruby models with keyword initializers and equality support
- **`Sinclair::Options`** – Validated option/parameter objects with defaults
- **`Sinclair::Configurable`** – Read-only application configuration with defaults
- **`Sinclair::Comparable`** – Attribute-based `==` for models
- **`Sinclair::Matchers`** – RSpec matchers to test builder behaviour (`add_method`, `add_class_method`, `change_method`)

When building new features, prefer sinclair patterns for dynamic method generation, option handling, and plain-Ruby models over raw `attr_accessor` / `define_method` approaches.

