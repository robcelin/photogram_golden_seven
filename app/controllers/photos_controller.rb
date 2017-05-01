class PhotosController < ApplicationController

  def show
    #The params hash looks like this :[the_id_number"=>"1"}]

    id_number = params["the_id_number"]
    p = Photo.find(id_number)

    @the_caption = p.caption
    @the_image_url = p.source
    @created_at = p.created_at
    @photo_id = p.id

    render("photos/show.html.erb")
  end

  def index
    @all_photos = Photo.order({:created_at => :desc })

    render("photos/index.html.erb")
  end

  def new_form

  render("photos/new_form.html.erb")
  end

  def create_row
    #render("photos/create_row.html.erb")

    p = Photo.new
    p.source = params["the_image_url"]
    p.caption = params["the_caption"]
    p.save

    redirect_to("http://localhost:3000/photos")
  end

  def edit_form
    @the_photo_to_be_edited = Photo.find(params[:the_id])

    render("photos/edit_form.html.erb")
  end

  def update_row
    p = Photo.find(params[:the_id])
    p.source = params[:the_source]
    p.caption = params[:the_caption]
    p.save

    @the_id = p.id

    redirect_to("/photos/#{@the_id}")
  end

  def delete_photo
    p =Photo.find(params[:the_id])
    p.destroy
    @remaining_count = Photo.count

    redirect_to("/photos")
  end

end
