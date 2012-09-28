# controller to manage uploads of tab-separated input files
#
class UploadsController < ApplicationController
  before_filter :ensure_signed_in

  def index
    @uploads = Upload.paginate(page: params[:page], per_page: 20)
  end

  def new
  end

  def show
    @upload = Upload.find(params[:id])
    if @upload.user == current_user
      render :show
    else
      render :access_denied, :status => :forbidden
    end
  end

  def create
    if params[:upload].blank?
      flash[:error] = "please select a file"
      render :new
    else
      process_upload
    end
  end

  private

    def process_upload
      begin
        @upload = Upload.from_file params[:upload], current_user
        redirect_to(@upload, notice: "upload success!")
      rescue StandardError => e
        flash[:error] = e.message
        render :new
      end
    end

end
