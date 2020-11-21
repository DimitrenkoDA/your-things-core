Router = Rucksack.router do
  get '/', Alive::Endpoints::Alive
  get '/me', Sessions::Endpoints::Show

  post '/operators/login', Sessions::Endpoints::Create, params: { kind: Sessions::Owners::Operator::KIND }
  post '/admins/login', Sessions::Endpoints::Create, params: { kind: Sessions::Owners::Admin::KIND }
  post '/users/login', Sessions::Endpoints::Create, params: { kind: Sessions::Owners::User::KIND }

  post '/users/sign_up', Users::Endpoints::SignUp

  get '/roles', Roles::Endpoints::Index

  get '/admins', Admins::Endpoints::Index
  post '/admins', Admins::Endpoints::Create
  get '/admins/:admin_id', Admins::Endpoints::Show
  # patch '/admins/:admin_id', Admins::Endpoints::Update
  # delete '/admins/:admin_id', Admins::Endpoints::Delete

  get '/shops', Shops::Endpoints::Index
  post '/shops', Shops::Endpoints::Create
  post '/shops/:shop_id/review', Shops::Endpoints::Review
  get '/shops/:shop_id', Shops::Endpoints::Show
  patch '/shops/:shop_id', Shops::Endpoints::Update
  delete '/shops/:shop_id', Shops::Endpoints::Delete

  # get '/shops/:shop_id/products', Products::Endpoints::Index
  # post '/shops/:shop_id/products', Products::Endpoints::Create
  # post '/shops/:shop_id/products/:product_id', Products::Endpoints::Review
  # get '/shops/:shop_id/products/:product_id', Products::Endpoints::Show
  # patch '/shops/:shop_id/products/:product_id', Products::Endpoints::Update
  # delete '/shops/:shop_id/products/:product_id', Products::Endpoints::Delete

  # get '/comments', Comments::Endpoints::Index
  # post '/comments', Comments::Endpoints::Create
  # post '/comments:comment_id', Comments::Endpoints::Review
  # get '/comments/:comment_id', Comments::Endpoints::Show
  # patch '/comments/:comment_id', Comments::Endpoints::Update
  # delete '/comments/:comment_id', Comments::Endpoints::Delete

  # get '/messages', Messages::Endpoints::Index
  # post '/messages', Messages::Endpoints::Create
  # get '/messages/:message_id', Messages::Endpoints::Show
  # patch '/messages/:message_id', Messages::Endpoints::Update
  # delete '/messages/:message_id', Messages::Endpoints::Delete

  get '/users', Users::Endpoints::Index
  post '/users', Users::Endpoints::Create
  post '/users/:user_id/seller', Users::Endpoints::Seller
  get '/users/:user_id', Users::Endpoints::Show
  patch '/users/:user_id', Users::Endpoints::Update
  delete '/users/:user_id', Users::Endpoints::Delete

  get '/users/:user_id/user_roles', UserRoles::Endpoints::Index
  get '/users/:user_id/user_roles/:user_role_id', UserRoles::Endpoints::Show
  post '/users/:user_id/user_roles/:user_role_id/activate', UserRoles::Endpoints::Activate
end
