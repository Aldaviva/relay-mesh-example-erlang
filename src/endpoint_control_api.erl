-module(endpoint_control_api).

-compile({parse_transform, leptus_pt}).

-export([init/3]).
-export([get/3]).
-export([post/3]).
-export([terminate/4]).

init(_Route, _Req, State) ->	
    {ok, State}.

% Capabilities method
% see https://relay.bluejeans.com/docs/mesh.html#capabilities
get("/:ipAddress/capabilities", Req, State) ->
	io:format("Received status request~n~p~n", 
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{port, leptus_req:qs_val(Req, <<"port">>)},
				{name, leptus_req:qs_val(Req, <<"name">>)}
			   ]]),
	Body = [
		{<<"JOIN">>, true},
		{<<"HANGUP">>, true},
		{<<"STATUS">>, true},
		{<<"MUTE_MICROPHONE">>, true},
	],
	{ok, {json, Body}, State};

% Status method
% see https://relay.bluejeans.com/docs/mesh.html#status
get("/:ipAddress/status", Req, State) ->
	io:format("Received status request~n~p~n", 
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{port, leptus_req:qs_val(Req, <<"port">>)},
				{name, leptus_req:qs_val(Req, <<"name">>)}
			   ]]),
	Body = [{<<"callActive">>, false}, {<<"microphoneMuted">>, false}],
	{ok, {json, Body}, State}.

% Join methoid
% see https://relay.bluejeans.com/docs/mesh.html#join
post("/:ipAddress/join", Req, State) ->
	io:format("Received join request~n~p~n",
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{dialString, leptus_req:qs_val(Req, <<"dialString">>)},
				{meetingId, leptus_req:qs_val(Req, <<"meetingId">>)},
				{passcode, leptus_req:qs_val(Req, <<"passcode">>)},
				{bridgeAddress, leptus_req:qs_val(Req, <<"bridgeAddress">>)},
				{endpoint, leptus_req:body(Req)}
			   ]]),
	{no_content, <<>>, State};

% Mute Microphone method
% see https://relay.bluejeans.com/docs/mesh.html#mutemicrophone
post("/:ipAddress/mutemicrophone", Req, State) ->
	io:format("Received mutemicrophone request~n~p~n",
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{endpoint, leptus_req:body(Req)}
			   ]]),
	{no_content, <<>>, State};

% Unmute Microphone method
% see https://relay.bluejeans.com/docs/mesh.html#mutemicrophone
post("/:ipAddress/unmutemicrophone", Req, State) ->
	io:format("Received unmutemicrophone request~n~p~n",
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{endpoint, leptus_req:body(Req)}
			   ]]),
	{no_content, <<>>, State};

% Hangup method
% see https://relay.bluejeans.com/docs/mesh.html#hangup
post("/:ipAddress/hangup", Req, State) ->
	io:format("Received hangup request~n~p~n",
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{endpoint, leptus_req:body(Req)}
			   ]]),
	{no_content, <<>>, State}.


terminate(_Reason, _Route, _Req, _State) ->
    ok.
