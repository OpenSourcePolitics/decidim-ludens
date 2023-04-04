# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Ludens do
    subject { described_class }

    it "has version" do
      expect(subject.version).to eq("0.26.2")
    end
  end
end
