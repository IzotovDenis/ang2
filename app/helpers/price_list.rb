# coding: utf-8
module PriceList
	
	def create_book
		require 'spreadsheet'
		Spreadsheet::Workbook.new
	end

	def export
	book = create_book
	sheet1 = book.create_worksheet
	format = Spreadsheet::Format.new :color => :black, :weight => :bold, :size => 10
   	sheet1.row(0).default_format = format
   	sheet1.row(0).push "Код", "Артикул", "Полное наименование", "Цена"
	row = 1
	@items = Item.all
	@items.each do |item|
		sheet1.row(row).push item.kod, item.article, item.full_title, item.price
		row +=1
	end
	book.write "/home/den/pricelist.xls"
	end

end