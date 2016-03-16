require 'rails_helper'
require 'spec_helper'

describe Brand do
	before {
		Brand.create(title: "Example Brand")
		Brand.create(title: "Second", created_at: Time.now-8.days)
		Brand.create(title: "Petr")
	}

  it "all" do
  	Brand.all.count.should be == 3
  end
end
