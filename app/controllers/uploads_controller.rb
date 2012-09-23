class UploadsController < ApplicationController
  before_filter :ensure_signed_in

  def index
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def create

    if params[:upload].blank?
      flash[:error] = "please select a file"
      render :index
    else
      process_upload
    end

  end

  private

    def process_upload

      begin
        upload = Upload.from_file params[:upload], current_user
        flash[:info] = "upload success!"
        redirect_to view_upload_path upload
      rescue StandardError => e
        flash[:error] = e.message
        render :index
      end

    end

end
