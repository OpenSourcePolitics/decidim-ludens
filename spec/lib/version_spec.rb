# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Ludens do
    subject { described_class }

    it "has version" do
      expect(subject.version).to eq("1.0.0")
    end

    it "has a Decidim compatibility version" do
      expect(subject.compatible_decidim_version).to eq("0.26.0")
    end
  end
end
