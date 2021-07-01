require "guard/compat/test/helper"
require "pry-byebug"

RSpec.describe Guard::Standardrb do
  it "has a version number" do
    expect(Guard::StandardrbVersion).not_to be nil
  end

  subject { Guard::Standardrb.new(options) }
  let(:options) { {} }

  describe "#options" do
    subject { super().options }

    context "by default" do
      let(:options) { {} }

      describe "[:fix]" do
        subject { super()[:fix] }
        it { should be_falsey }
      end

      describe "[:all_on_start]" do
        subject { super()[:all_on_start] }
        it { should be_falsey }
      end

      describe "[:progress]" do
        subject { super()[:progress] }
        it { should be_falsey }
      end
    end
  end

  describe "#start" do
    it "prints message" do
      allow(Guard::UI).to receive(:info)
      expect(Guard::UI).to receive(:info)
        .with("fix = false, all_on_start = false, progress = false")

      subject.start
    end

    context "when :all_on_start enabled" do
      let(:options) { {all_on_start: true} }

      it "runs all cops" do
        expect(subject).to receive(:run_all)
        subject.start
      end
    end

    context "when :all_on_start disabled" do
      let(:options) { {all_on_start: false} }

      it "does nothing" do
        expect(subject).not_to receive(:run_all)
        subject.start
      end
    end
  end

  describe "#run_on_additions" do
    it "prints message" do
      expect(Guard::UI).to receive(:info)
        .with("StandardRb a file was added")

      subject.run_on_additions([])
    end
  end

  describe "#run_on_modifications" do
    it "prints message" do
      expect(Guard::UI).to receive(:info)
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
