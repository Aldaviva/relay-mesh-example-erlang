-module(mesh).

-export([start/0]).

start() ->
	ok = application:start(mesh).
