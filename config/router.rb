Router = Rucksack.router do
  get "/", Alive::Endpoints::Alive
  get "/me", Sessions::Endpoints::Show

  post "/operators/login", Sessions::Endpoints::Create, params: { kind: Sessions::Owners::Operator::KIND }
  post "/users/login", Sessions::Endpoints::Create, params: { kind: Sessions::Owners::User::KIND }

  get "/users", Users::Endpoints::Index
  post "/users", Users::Endpoints::Create
  get "/users/:user_id", Users::Endpoints::Show
  patch "/users/:user_id", Users::Endpoints::Update
  delete "/users/:user_id", Users::Endpoints::Delete
end
