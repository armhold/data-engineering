class UploadsController < ApplicationController
  before_filter :ensure_signed_in

  def index

  end

  def view_upload
    @upload = Upload.find(params[:id])
  end

  def process_upload

    uploaded_io = params[:upload]

    # TODO: check filename collision
    file = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(file, 'w') do |f|
      f.write(uploaded_io.read)
    end

    # TODO: remove file?

    upload = Upload.from_file file
    redirect_to view_upload_path upload
  end

end
