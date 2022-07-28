# Decidim::Ludens

Participative assistant for administrators.

## Usage

The participative assistant is used to help administrators to administrate.
It gives them a list of to-dos, rewarding them with points and levels when they succeed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-ludens"
```

And then execute:

```bash
bundle
```

if migrations are not installed by themselves, execute

```bash
bundle exec rake decidim_ludens:install:migrations
```
 
When organizations are created, initialize the module by executing
```bash
bundle exec rake decidim_ludens:initialize
```

If you need to customize the actions, you can copy the yaml file by executing
```bash
bundle exec rake decidim_ludens:get_file
```

You can then customize it, removing and adding action as you want, and rerun the initialize rake task

## Contributing

See [Decidim](https://github.com/OpenSourcePolitics/decidim-ludens).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
