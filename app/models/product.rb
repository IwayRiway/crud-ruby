class Product < ApplicationRecord
    has_many :product_receiving_items, dependent: :destroy
    # enum status: [:suspend, :active], default: :suspend
     enum :status, { Suspend: 0, Active: 1}, default: :Suspend

     def self.import(file)
        accessible_attributes = ['part_id', 'part_name', 'status']
        spreadsheet = open_spreadsheet(file)
        header = spreadsheet.row(1)
        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          product = find_by(part_id: row["part_id"]) || new
          product.attributes = row.to_hash.slice(*accessible_attributes)
          product.save!
        end
      end

      def self.open_spreadsheet(file)
        case File.extname(file.original_filename)
            when ".csv" then Csv.new(file.path, nil, :ignore)
            when ".xls" then Roo::Excel.new(file.path) #       when ".xls" then Roo::Spreadsheet.open(file.path)
            when ".xlsx" then Roo::Excelx.new(file.path)
            else raise "Unknown file type: #{file.original_filename}"
        end
      end
      
      
end
