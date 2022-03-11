# Decidim::ParticipativeAssistant

Participative assistant for administrators.

## Usage

The participative assistant is used to help administrators to administrate.
It gives them a list of to-dos, rewarding them with points and levels when they succeed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-participative_assistant"
```

And then execute:

```bash
bundle
```

if migrations are not installed by themselves, execute

```bash
bundle exec rake decidim_participative_assistant:install:migrations
```
 
Initialize the module by executing
```bash
bundle exec rake decidim_participative_assistant:initialize
```

## Contributing

See [Decidim](https://github.com/decidim/decidim).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
