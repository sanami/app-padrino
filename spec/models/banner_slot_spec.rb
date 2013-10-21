require 'spec_helper'

describe BannerSlot do
  subject do
    FactoryGirl.create :banner_slot
  end

  it "should create subject" do
    subject.should_not be_nil
    subject.banner_contents.count.should == 0
  end

  describe 'scope' do
    it 'with_content' do
      s1 = FactoryGirl.create :banner_slot_with_content
      s2 = FactoryGirl.create :banner_slot

      all = BannerSlot.with_content.entries
      all.should include(s1)
      all.should_not include(s2)
    end

    it 'by_names' do
      s1 = FactoryGirl.create :banner_slot
      s2 = FactoryGirl.create :banner_slot
      s3 = FactoryGirl.create :banner_slot

      all = BannerSlot.by_names([s1.slot_name, s2.slot_name]).entries
      all.should include(s1, s2)
      all.should_not include(s3)
    end

    it 'by_time' do
      s1 = FactoryGirl.create :banner_slot, valid_from: 3, valid_till: 10
      s2 = FactoryGirl.create :banner_slot, valid_from: 3, valid_till: 5
      s3 = FactoryGirl.create :banner_slot, valid_from: 1
      s4 = FactoryGirl.create :banner_slot, valid_from: 8
      s5 = FactoryGirl.create :banner_slot, valid_till: 6

      all = BannerSlot.by_time(1).entries
      all.should include(s3, s5)
      all.should_not include(s1, s2, s4)

      all = BannerSlot.by_time(3).entries
      all.should include(s1, s2, s3, s5)
      all.should_not include(s4)

      all = BannerSlot.by_time(7).entries
      all.should include(s1, s3)
      all.should_not include(s2, s4, s5)

      all = BannerSlot.by_time(11).entries
      all.should include(s3, s4)
      all.should_not include(s1, s2, s5)
    end
  end

  it 'should find valid_slots' do
    s1 = FactoryGirl.create :banner_slot_with_content, valid_till: 12
    s2 = FactoryGirl.create :banner_slot_with_content, valid_from: 18
    s3 = FactoryGirl.create :banner_slot_with_content
    s4 = FactoryGirl.create :banner_slot

    all = BannerSlot.valid_slots([s1.slot_name, s2.slot_name], 6).entries
    all.should include(s1)
    all.should_not include(s2, s3, s4)

    all = BannerSlot.valid_slots([s1.slot_name, s2.slot_name], 21).entries
    all.should include(s2)
    all.should_not include(s1, s3, s4)

    all = BannerSlot.valid_slots([s1.slot_name, s2.slot_name, s3.slot_name], 15).entries
    all.should include(s3)
    all.should_not include(s1, s2, s4)
  end

  it 'should get random_banner' do
    s1 = FactoryGirl.create :banner_slot_with_content
    b1 = BannerSlot.random_banner(s1.slot_name)
    s1.banner_contents.should include b1
  end

end
