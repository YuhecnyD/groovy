class ExchangesController < ApplicationController
  def index
    @exchanges = Exchange.where(user: current_user)

    # @exchange = Exchange.where(requested_vinyl_id: )
  end

  def show
    @exchange = Exchange.last
    @message = Message.new
  end

  def create
    exchange = Exchange.new(requested_vinyl_id: params[:collections_vinyl_id], user: current_user, status: :pending)
    exchange.save!
    params[:collection_vinyl_ids].each do |cvid|
      offered_vinyls = OfferedVinyl.new(exchange: exchange, collection_vinyl_id: cvid)
      offered_vinyls.save!
    end
    redirect_to my_exchanges_path
    # rescue
    # render :new, status: :unprocessable_entity
  end

  def new
    collections = current_user.collections
    @collections_vinyls = CollectionVinyl.where(collection: collections)

    @requested_vinyl = CollectionVinyl.find(params[:collections_vinyl_id])
    # @exchange = Exchange.new(requested_vinyl_id: params[:collections_vinyl_id], user: current_user, status: :pending)
    @exchange = Exchange.new
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:status, :requested_vinyl_id, :user_id, :offered_vinyl_id)
  end
end
