class UploadsController < ApplicationController

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

    @upload = parse_upload file

    # TODO: remove file?

    redirect_to view_upload_path @upload
  end

  private

  def parse_upload(file)

    result = Upload.new

    File.open file do |f|
      while line = f.gets
        puts "process line: #{f.lineno}"
        next if f.lineno == 1

        customer_name, item_description, item_price, quantity, merchant_address, merchant_name = line.split /\t/

        merchant = Merchant.find_or_initialize_by_name merchant_name
        merchant.address = merchant_address
        merchant.save

        customer = Customer.find_or_initialize_by_name customer_name
        customer.save

        item = Item.new
        item.description = item_description
        item.price = item_price

        purchase = Purchase.new
        purchase.quantity = quantity
        purchase.item = item
        purchase.customer = customer
        purchase.merchant = merchant

        result.purchases << purchase
      end
    end

    result.save
    result
  end

end
