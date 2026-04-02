# FractualI18n

Co-locate Rails translation files alongside your views. Instead of maintaining a single large `config/locales/en.yml`, place small `.yml` files next to the templates they belong to. The gem automatically namespaces translation keys based on the file path.

## How it works

Given this structure:

```
app/views/users/index.html.erb
app/views/users/index.yml
app/views/users/_form.html.erb
app/views/users/_form.yml
```

And `index.yml`:

```yaml
en:
  title: "Users"
```

The translation is accessible via `t(".title")` in `index.html.erb`, which resolves through the key `users.index.title`. Partial prefixes (underscores) are stripped automatically — `_form.yml` maps to `users.form`.

## Installation

Add to your Gemfile:

```ruby
gem "fractual_i18n"
```

## Usage

Include the backend in a Rails initializer:

```ruby
# config/initializers/fractual_i18n.rb
I18n::Backend::Simple.include(FractualI18n::Backend)
```

Add view translation files to the I18n load path:

```ruby
# config/application.rb
config.i18n.load_path += Dir[Rails.root.join("app/views/**/*.yml")]
```

That's it. The gem's railtie automatically detects `app/views` as a fractual path. In development, newly added `.yml` files are picked up without a server restart.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
