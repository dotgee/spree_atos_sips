Spree::Core::Engine.routes.append do

  match '/atos/atos_confirm' => 'atos#atos_confirm', :via => :post
  match '/atos/atos_cancel' => 'atos#atos_cancel', :via => :post
  match '/atos/atos_auto_response' => 'atos#atos_auto_response', :via => :post

end
