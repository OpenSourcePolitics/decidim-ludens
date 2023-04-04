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
 
You may need to install a package by yourself with
```bash
npm install confetti-js --save
```

If you need to add the module on an existing platform, you can retrieve old actions by executing
```bash
bundle exec rake decidim_ludens:retrieve_actions
```

If you need to remove unregistered actions, after updating the config file for example, you can execute
```bash
bundle exec rake decidim_ludens:remove_unregistered_actions
```

If you need to customize the actions, you can copy the yaml file by executing
```bash
bundle exec rake decidim_ludens:get_file
```
You can then customize it, removing and adding action as you want, and then execute the retrieve commands and remove unregistered actions command

## Contributing

See [Decidim](https://github.com/OpenSourcePolitics/decidim-ludens).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
