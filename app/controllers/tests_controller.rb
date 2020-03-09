class TestsController < ApplicationController

  # require 'payjp'
  
  def show
  end

  def done
    Payjp.api_key = "sk_test_9c5b009b4c2db8f24416cfd2"
    Payjp::Charge.create(
      amount: 1100, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると生成されるトークン
      currency: 'jpy'
    )
    @items= Items.find(params[:id])
    @items.update( buyer_id: current_user.id)
  end
end