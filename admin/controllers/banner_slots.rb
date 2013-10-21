Banners::Admin.controllers :banner_slots do
  get :index do
    @title = "Banner_slots"
    @banner_slots = BannerSlot.all
    render 'banner_slots/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'banner_slot')
    @banner_slot = BannerSlot.new
    render 'banner_slots/new'
  end

  post :create do
    @banner_slot = BannerSlot.new(params[:banner_slot])
    if @banner_slot.save
      @title = pat(:create_title, :model => "banner_slot #{@banner_slot.id}")
      flash[:success] = pat(:create_success, :model => 'BannerSlot')
      params[:save_and_continue] ? redirect(url(:banner_slots, :index)) : redirect(url(:banner_slots, :edit, :id => @banner_slot.id))
    else
      @title = pat(:create_title, :model => 'banner_slot')
      flash.now[:error] = pat(:create_error, :model => 'banner_slot')
      render 'banner_slots/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "banner_slot #{params[:id]}")
    @banner_slot = BannerSlot.find(params[:id])
    if @banner_slot
      render 'banner_slots/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'banner_slot', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "banner_slot #{params[:id]}")
    @banner_slot = BannerSlot.find(params[:id])
    if @banner_slot
      if @banner_slot.update_attributes(params[:banner_slot])
        flash[:success] = pat(:update_success, :model => 'Banner_slot', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:banner_slots, :index)) :
          redirect(url(:banner_slots, :edit, :id => @banner_slot.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'banner_slot')
        render 'banner_slots/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'banner_slot', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Banner_slots"
    banner_slot = BannerSlot.find(params[:id])
    if banner_slot
      if banner_slot.destroy
        flash[:success] = pat(:delete_success, :model => 'Banner_slot', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'banner_slot')
      end
      redirect url(:banner_slots, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'banner_slot', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Banner_slots"
    unless params[:banner_slot_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'banner_slot')
      redirect(url(:banner_slots, :index))
    end
    ids = params[:banner_slot_ids].split(',').map(&:strip)
    banner_slots = BannerSlot.find(ids)
    
    if banner_slots.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Banner_slots', :ids => "#{ids.to_sentence}")
    end
    redirect url(:banner_slots, :index)
  end
end
