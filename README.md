# Testy

Testy is a simple websocket server intended as a code sample.

## Installation

1. Clone project from GitHub.
2. Ensure you have proper versions of Elixir and Erlang installed. Testy uses OTP 23.2 and Elixir 1.11.2-otp-23. If you use asdf, just run `asdf install` in project root(all the usual gotchas about Erlang :crypto apply).
4. Run `mix deps.get` to fetch the dependencies.
5. (Optional) Run `mix test` to check if all is alright(it should be).
6. Run the project by `mix run --no-halt` or `iex -S mix` if you prefer to run interactively.
7. Go to [localhost:4001](http://localhost:4001) in your web browser - you should see the message that server is running.

## Using it

1. To interact with websocket server you are going to need a websocket client. Unless you have one of choice, the simplest option is to use a Google Chrome extension [SimpleWebSocketClient](https://chrome.google.com/webstore/detail/simple-websocket-client/pfdhoblngboilpfeibdedpjgfnlcodoo?hl=en)

2. To connect to a server, open a connection at `ws://localhost:4001/ws`.

3. Server accepts two types of messages - add and multiply and they have to be delivered in JSON format with custom structure. Examples of both:
- Add: `{"ref":2,"type":"add","payload":{"a":1,"b":1}}`
- Multiply: `{"ref":2,"type":"multiply","payload":{"a":1,"b":1}}`

## Reading the code
I tried to make the code as readable as possible. but there are a few harder parts. If you got any questions, feel free to ping me.

## Kudos
Thanks to Benjamin Tan for his [article](https://benjamintan.io/blog/2014/02/12/phoenix-elixir-web-framework-and-websockets/) from 2014 that showed me how to actually start with this back in 2015. Big thanks to Elixir and Phoenix teams, I learned a lot from both your excellent tutorials/documentation and reading your code.
