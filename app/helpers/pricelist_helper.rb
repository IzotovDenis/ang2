# coding: utf-8
module PricelistHelper

	def generate

	end

	def create_pricelist
		begin
			require 'spreadsheet'
			@groups = Group.able.arrange_as_array(:order=>"position").each {|n| n.position ="#{n.depth}" }
			book = Spreadsheet::Workbook.new
			format = Spreadsheet::Format.new :size => 8
			format_head = Spreadsheet::Format.new :size => 8, :weight => :bold, :horizontal_align => :center
			# Head formats
			pricelist_title_format = Spreadsheet::Format.new :size => 12, :horizontal_align => :center
			data_format = Spreadsheet::Format.new :size => 8, :horizontal_align => :center
			text_format = Spreadsheet::Format.new :size => 10, :horizontal_align => :center, :text_wrap => :true
			link_format = Spreadsheet::Format.new :size => 14, :weight => :bold, :horizontal_align => :center
			# End head formats
			title_format = Spreadsheet::Format.new :size => 9, :weight => :bold, :pattern => 1, :pattern_fg_color => :silver, :bottom=>:thin, :top=>:thin
			sheet = book.create_worksheet
			sheet[0,4] = "Прайс-лист ИП Пономарев Е.В."
			sheet.row(0).set_format 4, pricelist_title_format
			sheet[1,4] = "Дата формирования #{Russian::strftime(DateTime.now, '%H:%M %d %B %Y')}"
			sheet.row(1).set_format 4, data_format
			sheet[2,4] = "Воспользоваться удобным поиском, посмотреть актуальные цены, фотографии товара, скачать свежий прайс-лист или сделать заказ он-лайн вы можете на нашем сайте"
			sheet.row(2).set_format 4, text_format
			[20,20,50,20].each_with_index do |value, index|
				sheet.row(index).height = value
			end
			sheet[3,4] = Spreadsheet::Link.new "http://planeta-avtodv.ru/?marker=price_list_title", 'ПЕРЕЙТИ НА САЙТ'
			sheet.row(3).set_format 4, link_format
			sheet.row(4).concat %w{Фото Код Бренд Артикул Наименование Тип Размер OEM Кросс Применяемость Цена Заказ}
			12.times do |x|
				sheet.row(4).set_format x, format_head
			end
			row = 5
			@groups.each do |group|
				sheet[row,4] = group.title
				12.times do |x|
					sheet.row(row).set_format x, title_format
				end
				row = add_items(sheet, group, row, format)
				row = row+1
				[7,7,13,13,70,15,10,23,13,23,13,7].each_with_index do |value,index|
					sheet.column(index).width = value
				end
			end
			book.write 'public/sys/pricelist/ipponomarev.xls'
			system ("zip -j -o public/sys/pricelist/ponomarev-pricelist.zip public/sys/pricelist/ipponomarev.xls")
			return true
		rescue => e
			puts e.to_s
			return false
		end
	end

	def add_items(sheet, group, row, format)
		format = Spreadsheet::Format.new :size => 8, :bottom=>:thin, :top=>:thin, :left => :thin, :right => :thin, :text_wrap => :true
		kod_format = Spreadsheet::Format.new :size => 8, :horizontal_align => :right, :bottom=>:thin, :top=>:thin, :left => :thin, :right => :thin
		link_format = Spreadsheet::Format.new :size => 8, :color=>:blue, :horizontal_align => :right, :bottom=>:thin, :top=>:thin, :left => :thin, :right => :thin
		order_format = title_first = Spreadsheet::Format.new :size => 8, :weight => :bold, :pattern => 1, :pattern_fg_color => :yellow, :bottom=>:thin, :top=>:thin, :left => :thin
		price_format = Spreadsheet::Format.new(:number_format => "#,##0.00\\ [$руб.-419];\\-#,##0.00\\ [$руб.-419]", :size => 8, :bottom=>:thin, :top=>:thin, :left => :thin, :right => :thin)
		items = Item.where(:group_id=>group.id).able.includes(:prices).sort_by &:full_title
			items.each do |item|
			row = row+1
			sheet[row,0] = Spreadsheet::Link.new "http://planeta-avtodv.ru/items/#{item.properties["Код товара"]}", 'фото' if item.image.file
			sheet[row,1] = item.properties["Код товара"].to_i
			sheet[row,2] = item.brand.strip if item.brand
			sheet[row,3] = item.article.strip if item.article
			sheet[row,4] = item.properties["Полное наименование"].strip if item.properties["Полное наименование"]
			sheet[row,5] = item.properties["Тип"].strip if item.properties["Тип"]
			sheet[row,6] = ""
			sheet[row,7] = item.properties["ОЕМ"].strip if item.properties["ОЕМ"]
			sheet[row,8] = item.cross.join(", ") if item.cross
			sheet[row,9] = item.properties["Применяемость"].strip if item.properties["Применяемость"]
			sheet[row,10] = item.price
			11.times do |x|
				sheet.row(row).set_format x, format
			end
			sheet.row(row).set_format 0, link_format
			sheet.row(row).set_format 1, kod_format
			sheet.row(row).set_format 10, price_format
			sheet.row(row).set_format 11, order_format
		end
		row
	end

end
