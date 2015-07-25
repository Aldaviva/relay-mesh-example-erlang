-module(mesh_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    io:fwrite("Starting leptus...~n"),
    Handlers = [{'_', [{endpoint_control_api, undefined_state}]}],
    Options = [{port, 6374},
               {ip, {0,0,0,0}}],               
    {ok, _} = leptus:start_listener(http, Handlers, Options),
    io:fwrite("Press Ctrl+C Ctrl+C to exit~n"),
    mesh_sup:start_link().

stop(_State) ->
    ok.
