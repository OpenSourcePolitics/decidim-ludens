# frozen_string_literal: true


require "decidim/dev/common_rake"

def install_module(path)
  Dir.chdir(path) do
    system("bundle exec rake decidim_participative_assistant:install:migrations")
    system("bundle exec rake db:migrate")
    system("bundle exec rake decidim_participative_assistant:initialize")
  end
end

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rake db:seed")
  end
end

desc "Generates a dummy app for testing"
task test_app: "decidim:generate_external_test_app" do
  ENV["RAILS_ENV"] = "test"
  install_module("spec/decidim_dummy_app")
end

desc "Generates a development app"
task development_app: "decidim:generate_external_development_app" do
  install_module("development_app")
  seed_db("development_app")
end
