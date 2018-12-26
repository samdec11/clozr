require_relative "../src/main.rb"

RSpec.describe "Main" do
  describe "assess" do
    subject { Main.assess(input) }

    context "when curly braces are evenly balanced" do
      let(:input) { "{text}" }

      it { is_expected.to eq("This is valid") }
    end

    context "when curly braces are not evenly balanced" do
      let(:input) { "{text" }

      it { is_expected.to eq("Unclosed { at index 0") }
    end

    context "with multiple openers and closers" do
      context "when balanced" do
        let(:input) do
          <<~EOS
            {
              "list": [{
                "text": "This (is some) text"
              }]
            }
          EOS
        end

        it { is_expected.to eq("This is valid") }
      end

      context "when an opener is missing a closer" do
        let(:input) do
          <<~EOS
            {
              "list": [{
                "text": "This (is some) text"
              ]
            }
          EOS
        end

        it { is_expected.to eq("Unclosed { at index 13") }
      end

      context "when a closer is missing an opener" do
        let(:input) do
          <<~EOS
            {
              "list": [
                "text": "This (is some) text"
              }]
            }
          EOS
        end

        it { is_expected.to eq("Unopened } at index 50")}
      end
    end
  end
end
