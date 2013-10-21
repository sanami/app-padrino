require 'ms_lorem'

module Seed
  class Banners
    def run(slot_count, content_count, max_content_per_slot)
      content_count.times do
        attrs = {
          html_content: Lorem.new(100)
        }

        BannerContent.create! attrs
      end

      slot_count.times do |i|
        attrs = {
          slot_name: "slot#{i+1}"
        }

        slot = BannerSlot.create! attrs
        rand(max_content_per_slot).times do
          slot.banner_contents << BannerContent.all.sample
        end
      end
    end
  end
end
