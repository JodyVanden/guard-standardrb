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

    context "when options are customized" do
      let(:options) { {fix: true, progress: true, all_on_start: true} }

      describe "[:fix]" do
        subject { super()[:fix] }
        it { should be_truthy }
      end

      describe "[:all_on_start]" do
        subject { super()[:all_on_start] }
        it { should be_truthy }
      end

      describe "[:progress]" do
        subject { super()[:progress] }
        it { should be_truthy }
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

  describe "#run_all" do
    it "calls inspect_with_standardrb" do
      expect(subject).to receive(:inspect_with_standardrb)
      subject.run_all
    end

    it "calls inspect_with_standardrb without arguments" do
      expect(subject).to receive(:system).with("bundle", "exec", "standardrb")
      subject.run_all
    end
  end

  describe "#run_on_additions" do
    it "prints message" do
      expect(Guard::UI).to receive(:info)
        .with("StandardRb a file was added")

      subject.run_on_additions([])
    end

    it "calls inspect_with_standardrb with paths" do
      paths = ["new_file.rb"]
      expect(subject).to receive(:inspect_with_standardrb).with(paths)
      subject.run_on_additions(paths)
    end

    it "handles multiple paths" do
      paths = ["file1.rb", "file2.rb", "file3.rb"]
      expect(subject).to receive(:inspect_with_standardrb).with(paths)
      subject.run_on_additions(paths)
    end
  end

  describe "#run_on_modifications" do
    it "prints message" do
      expect(Guard::UI).to receive(:info)
        .with("StandardRb a file was modified")

      subject.run_on_modifications([])
    end

    it "calls inspect_with_standardrb with paths" do
      paths = ["file.rb"]
      allow($stdout).to receive(:puts)
      expect(subject).to receive(:inspect_with_standardrb).with(paths)
      subject.run_on_modifications(paths)
    end

    context "stdout output" do
      it "outputs paths to stdout when paths present" do
        paths = ["file.rb", "another.rb"]
        allow(subject).to receive(:inspect_with_standardrb)
        expect($stdout).to receive(:puts).with(paths)
        subject.run_on_modifications(paths)
      end

      it "outputs paths to stdout even when empty array" do
        paths = []
        allow(subject).to receive(:inspect_with_standardrb)
        expect($stdout).to receive(:puts).with(paths)
        subject.run_on_modifications(paths)
      end
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

    context "command construction" do
      it "calls system with correct base arguments" do
        expect(subject).to receive(:system).with("bundle", "exec", "standardrb")
        subject.inspect_with_standardrb
      end

      context "with no paths" do
        it "runs standardrb without file arguments" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb")
          subject.inspect_with_standardrb([])
        end
      end

      context "with paths" do
        let(:paths) { ["file1.rb", "file2.rb"] }

        it "includes paths in command" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb", "file1.rb", "file2.rb")
          subject.inspect_with_standardrb(paths)
        end
      end

      context "with fix enabled" do
        let(:options) { {fix: true} }

        it "includes --fix in command" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb", "--fix")
          subject.inspect_with_standardrb
        end

        it "includes --fix and paths in command" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb", "--fix", "test.rb")
          subject.inspect_with_standardrb(["test.rb"])
        end
      end

      context "with progress enabled" do
        let(:options) { {progress: true} }

        it "includes --format progress in command" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb", "--format", "progress")
          subject.inspect_with_standardrb
        end

        it "includes --format progress and paths in command" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb", "--format", "progress", "test.rb")
          subject.inspect_with_standardrb(["test.rb"])
        end
      end

      context "with all options enabled" do
        let(:options) { {fix: true, progress: true} }

        it "includes all arguments in command" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb", "--fix", "--format", "progress")
          subject.inspect_with_standardrb
        end

        it "includes all arguments and paths in command" do
          expect(subject).to receive(:system).with("bundle", "exec", "standardrb", "--fix", "--format", "progress", "test.rb", "another.rb")
          subject.inspect_with_standardrb(["test.rb", "another.rb"])
        end
      end
    end
  end
end
