require "guard/compat/test/helper"
require "pry-byebug"

RSpec.describe Guard::Standardrb do
  it "has a version number" do
    expect(Guard::StandardrbVersion).not_to be nil
  end

  subject { Guard::Standardrb.new(fix: false) }

  describe "#start" do
    it "prints message" do
      allow(Guard::Compat::UI).to receive(:info)
      expect(Guard::Compat::UI).to receive(:info)
        .with("Standardrb --fix = false")

      subject.start
    end
  end

  describe "#run_on_modifications" do
    it "prints message" do
      expect(Guard::Compat::UI).to receive(:info)
        .with("StandardRb a file was modified")

      subject.run_on_modifications([])
    end
  end

  describe "#inspect_with_standardrb" do
    let(:paths) { ["lorem", "ipsum"] }
    let(:args) { ["bundle", "exec", "standardrb"] }

    it "runs standardrb" do
      expect(subject).to receive(:inspect_with_standardrb)
      subject.inspect_with_standardrb
    end

    it "runs standardrb on specific files passed in" do
      expect(subject).to receive(:inspect_with_standardrb).with(paths)
      subject.run_on_modifications(paths)
    end
  end
end
