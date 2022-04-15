# frozen_string_literal: true

print "Creating seeds for decidim-participative-assistant...\n"

require "decidim/faker/localized"

# Since we usually migrate and seed in the same process, make sure
# that we don't have invalid or cached information after a migration.
# decidim_tables = ActiveRecord::Base.connection.tables.select do |table|
#   table.starts_with?("decidim_")
# end
# decidim_tables.map do |table|
#   table.tr("_", "/").classify.safe_constantize
# end.compact.each(&:reset_column_information)
#
# Decidim::Organization.all.each do |organization|
#   organization.update!(assistant: {
#     score: 0,
#     flash: "",
#     last: -1
#   })
#
#   Decidim::ParticipativeAssistant::ParticipativeAction.create!(
#     completed: false,
#     points: 1,
#     resource: Decidim::Assembly,
#     action: "publish",
#     category: "Edition",
#     recommendation: "Publish an Assembly",
#     organization: organization,
#     documentation: "#"
#   )
#
#   Decidim::ParticipativeAssistant::ParticipativeAction.create!(
#     completed: false,
#     points: 2,
#     resource: Decidim::Assembly,
#     action: "unpublish",
#     category: "Edition",
#     recommendation: "Unublish an Assembly",
#     organization: organization,
#     documentation: "#"
#   )
#
#   Decidim::ParticipativeAssistant::ParticipativeAction.create!(
#     completed: false,
#     points: 3,
#     resource: Decidim::Assembly,
#     action: "create",
#     category: "Edition",
#     recommendation: "Create an Assembly",
#     organization: organization,
#     documentation: "https://en.docs-decidim.opensourcepolitics.eu/article/94-lespace-assemblees"
#   )
#
#   Decidim::ParticipativeAssistant::ParticipativeAction.create!(
#     completed: false,
#     points: 3,
#     resource: Decidim::ParticipatoryProcess,
#     action: "create",
#     category: "Edition",
#     recommendation: "Create a participatory process",
#     organization: organization,
#     documentation: "#"
#   )
#
#   Decidim::ParticipativeAssistant::ParticipativeAction.create!(
#     completed: false,
#     points: 3,
#     resource: Decidim::ParticipatoryProcess,
#     action: "publish",
#     category: "Edition",
#     recommendation: "Publish a participatory process",
#     organization: organization,
#     documentation: "#"
#   )
#
#   Decidim::ParticipativeAssistant::ParticipativeAction.create!(
#     completed: false,
#     points: 3,
#     resource: Decidim::ParticipatoryProcess,
#     action: "unpublish",
#     category: "Edition",
#     recommendation: "Unpublish a participatory process",
#     organization: organization,
#     documentation: "#"
# )
# end
