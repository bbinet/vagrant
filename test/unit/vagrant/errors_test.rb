require File.expand_path("../../base", __FILE__)

describe Vagrant::Errors::VagrantError do
  describe "subclass with error key" do
    let(:klass) do
      Class.new(described_class) do
        error_key("test_key")
      end
    end

    subject { klass.new }

    it "should use the translation for the message" do
      subject.to_s.should == "test value"
    end

    its("status_code") { should eq(1) }
  end

  describe "passing error key through options" do
    subject { described_class.new(_key: "test_key") }

    it "should use the translation for the message" do
      subject.to_s.should == "test value"
    end
  end

  describe "subclass with error message" do
    let(:klass) do
      Class.new(described_class) do
        error_message("foo")
      end
    end

    subject { klass.new(data: "yep") }

    it "should use the translation for the message" do
      subject.to_s.should == "foo"
    end

    it "should expose translation keys to the user" do
      expect(subject.extra_data.length).to eql(1)
      expect(subject.extra_data).to have_key(:data)
      expect(subject.extra_data[:data]).to eql("yep")
    end
  end
end
