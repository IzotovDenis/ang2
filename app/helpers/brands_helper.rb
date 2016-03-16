module BrandsHelper

def create_brands
Brand.create(:title=>item.brand.strip) if !Brand.where('LOWER(title) = ?', item.brand.mb_chars.downcase.to_s.strip).exists?
end

end