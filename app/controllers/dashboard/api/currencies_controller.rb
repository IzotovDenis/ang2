class Dashboard::Api::CurrenciesController < Dashboard::ApiController
  respond_to :json
  before_action :set_currency, only: [:show, :destroy]

  def index
    @currencies = Currency.all
  end

  def show

  end

  def create
    puts currency_params
    @currency = Currency.where(:name=>currency_params[:name].upcase).first_or_initialize
    if @currency.save
      render :json=> {:success=>true}
    end
  end

  def destroy
    if @currency.destroy
      render :json => {success: true}
    end
  end

  private

  def set_currency
    @currency = Currency.find(params[:id])
  end

  def currency_params
    params.require(:currency).permit(:name) 
  end
end
