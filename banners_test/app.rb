module Banners
  class BannersTest < Padrino::Application
    register Padrino::Rendering
    register Padrino::Helpers

    enable :sessions

    get '/' do
      if params[:slot].present?
        banner = BannerSlot.random_banner(params[:slot])
        if banner
          banner.html_content
        else
          "No banner"
        end
      else
        @banner_slots = BannerSlot.all
        render 'index'
      end
    end

  end
end
