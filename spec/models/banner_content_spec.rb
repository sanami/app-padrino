require 'spec_helper'

describe BannerContent do
  subject do
    FactoryGirl.create :banner_content
  end

  it "should create subject" do
    subject.should_not be_nil
  end
end
