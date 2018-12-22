require_relative "../src/main.rb"

RSpec.describe "Main" do
  describe "run" do
    subject { Main.run(input) }

    context "when parentheses are evenly balanced" do
      let(:input) { "(text)" }

      it { is_expected.to eq("This is valid") }
    end

    context "when parentheses are not evenly balanced" do
      let(:input) { "(text" }

      it do
        is_expected.to eq(
          <<~EOS
            (text
            ^    
          EOS
        )
      end
    end
  end
end
