require 'spec_helper'

describe Seed::Banners do
  it "should create subject" do
    subject.should_not == nil
  end

  it "should run" do
    [ BannerSlot, BannerContent ].each {|m| m.count.should == 0 }

    subject.run(5, 10, 3)

    BannerSlot.count.should == 5
    BannerContent.count.should == 10

    pp BannerSlot.all.entries
  end

end
