# GraphqlUsersApi

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  * Start Credo with `mix credo`
  * Start a console with `iex -S mix`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


## NOTES:
I wanted to keep things simple and not add functionality that is specific to 
some apps, therefore:

- I didn't add Email or Phone fields to User model, this is something you can do.
- The security of the application is done through username/password, any other
  means of authentication should be created by you.
- I'm using a full_name field in User model because from an UX standpoint, having
  first_name and last_name does not add any extra value.
