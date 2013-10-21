Banners::Admin.controllers :banner_contents do
  get :index do
    @title = "Banner_contents"
    @banner_contents = BannerContent.all
    render 'banner_contents/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'banner_content')
    @banner_content = BannerContent.new
    render 'banner_contents/new'
  end

  post :create do
    @banner_content = BannerContent.new(params[:banner_content])
    if @banner_content.save
      @title = pat(:create_title, :model => "banner_content #{@banner_content.id}")
      flash[:success] = pat(:create_success, :model => 'BannerContent')
      params[:save_and_continue] ? redirect(url(:banner_contents, :index)) : redirect(url(:banner_contents, :edit, :id => @banner_content.id))
    else
      @title = pat(:create_title, :model => 'banner_content')
      flash.now[:error] = pat(:create_error, :model => 'banner_content')
      render 'banner_contents/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "banner_content #{params[:id]}")
    @banner_content = BannerContent.find(params[:id])
    if @banner_content
      render 'banner_contents/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'banner_content', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "banner_content #{params[:id]}")
    @banner_content = BannerContent.find(params[:id])
    if @banner_content
      if @banner_content.update_attributes(params[:banner_content])
        flash[:success] = pat(:update_success, :model => 'Banner_content', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:banner_contents, :index)) :
          redirect(url(:banner_contents, :edit, :id => @banner_content.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'banner_content')
        render 'banner_contents/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'banner_content', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Banner_contents"
    banner_content = BannerContent.find(params[:id])
    if banner_content
      if banner_content.destroy
        flash[:success] = pat(:delete_success, :model => 'Banner_content', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'banner_content')
      end
      redirect url(:banner_contents, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'banner_content', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Banner_contents"
    unless params[:banner_content_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'banner_content')
      redirect(url(:banner_contents, :index))
    end
    ids = params[:banner_content_ids].split(',').map(&:strip)
    banner_contents = BannerContent.find(ids)
    
    if banner_contents.each(&:destroy)
    
      flash[:success] = pat(:destroy_many_success, :model => 'Banner_contents', :ids => "#{ids.to_sentence}")
    end
    redirect url(:banner_contents, :index)
  end
end
