alias Vote.Accounts.Credential

Credential.changeset(%Credential{}, %{ 
  email: "alex@fuchsberger.us",  
  password: "password"
}) 
|> Vote.Repo.insert!
