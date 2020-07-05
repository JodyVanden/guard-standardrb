require "guard/compat/test/helper"

RSpec.describe Guard::Standardrb do
  it "has a version number" do
    expect(Guard::StandardrbVersion).not_to be nil
  end

  let(:standardrb) { Guard::Standardrb.new }

  describe "#start" do
    it "prints message" do
      expect(Guard::Compat::UI).to receive(:info)
        .with("Inspecting Ruby code style of all files with standardrb")

      standardrb.start
    end
  end

  describe "#run_on_modifications" do
    it "prints message" do
      expect(Guard::Compat::UI).to receive(:info)
        .with("StandardRb a file was modified")

      standardrb.run_on_modifications([])
    end
  end

  describe "#inspect_with_standardrb" do
    let(:paths) { ["lorem", "lorem"] }

    it "runs standardrb on the files" do
      allow_any_instance_of(Kernel).to receive(:system)
      expect(standardrb.inspect_with_standardrb(paths)).to eq(paths)
    end
  end
end
