class ProductReceiving < ApplicationRecord
    has_many :product_receiving_items, dependent: :destroy
    accepts_nested_attributes_for :product_receiving_items, allow_destroy: true, reject_if: proc { |att| att['product_id'].blank? }
    enum :status, { New: 0, approve1: 1, cancel1: 2, approve2: 3, cancel2: 4, approve3: 5, cancel3: 6}, default: :New

    # before_create :set_code  
    # def generate_code()  
    #     # charset = %w{ 2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z}  
    #     # (0...size).map{ charset.to_a[rand(charset.size)] }.join  

    #     "PRD-RCV/#{Time.now.strftime("%Y")}/#{Time.now.strftime("%m")}/#{.to_s.rjust(4, "0")}"
    # end  
    # def set_code  
    #     self.document_number = generate_code()  
    # end
end
