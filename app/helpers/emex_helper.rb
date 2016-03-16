module EmexHelper

	def open_page(url)
		require "open-uri"
		require "nokogiri"
		require "rubygems"
		Nokogiri::HTML(open(url,"User-Agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36", "Cookie" =>cookie))
	end

	def start_emex(query, brand)
		a = []
		page = open_page("http://www.emex.ru/findauth?Fs.ChkMargin=False&Fs.Margin=0&cbRegions=%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0&sortField=&sortDirection=&dgonumber=&typeClient=rozn&cbAmount=&MakeLogo=&Sid=b2vb7urfbdbrh7fs528xndgx5cbt6zsdt8fwhs9r24mrx89d5b9nzbjcacmmnnschcnxnlq&QueryDetail=#{query}&Fs.CurrencyId=34")
		page.css('.brand .this').each do |elem|
			if elem.text == brand
				a.push(elem.parent.parent.at(".articul").text)
			end
		end
		a.uniq!
		query = ""
		a.map { |a| query << " #{brand} #{a} "} ;nil
		return query
	end

	def cookie
		"visitor_id=144115188112251795; rrpusid=5506258b1e99461748339632; .EMEX=7B508B251F10ECEB256ADD12284E91A91E2F3A8E400AC96909EEDBEFC040853B3FEC4F93C051A5279659FFAF152A58F4375538912208F19381B8D75407A371A50996E7C16E5B3706D4474C5D11670EAA91775DD19C8E5E0858C648BB8A3188F33AD5110D477A888BC4DD92021BA2929188774A71C930A3D273F4E965F4922188; __RequestVerificationToken=9_UXmoaWMt2OsFFooqew3fsPatFBhRXuN8Lvr3s4aFxD6iRQu3wyx91IrHCDtSpD0mPUr3wg_dqgUd5S-qXFAF0aTRBluCq9leYO54R1RM62jYkC7kfZx4pZShe5m6OhdHfl-V2Y_1Z9JPRQaA7b7g2; NSC_xxx.fnfy.sv!gps!DT=ffffffffc3a01c1c45525d5f4f58455e445a4a423652; lastRegionsClearing=1; userRegion=%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0; rrrbt=; rcuid=5506258b1e99461748339631; rrlpuid=; _ga=GA1.2.1995773210.1426466186; LastTimeTmQuery=Wed%20Apr%2008%202015%2012%3A58%3A18%20GMT%2B1000%20(YAKT)"
	end
end