class Dashboard::Api::RatesController < Dashboard::ApiController
  respond_to :json
  before_action :set_currency, only: [:create]

  def create
    if @currency
      if @currency.rates.create(:value=>rate_params[:value].to_s.gsub(',', '.').to_f)
        respond_with @currency
      end
    end
  end

  private

  def set_currency
    @currency = Currency.find(params[:currency_id])
  end

  def rate_params
    params.require(:rate).permit(:value)
  end

end
