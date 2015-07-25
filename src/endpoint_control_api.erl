-module(endpoint_control_api).

-compile({parse_transform, leptus_pt}).

-export([init/3]).
-export([get/3]).
-export([post/3]).
-export([terminate/4]).

init(_Route, _Req, State) ->	
    {ok, State}.

get("/:ipAddress/callactive", Req, State) ->
	io:format("Received callactive request~n~p~n", 
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{port, leptus_req:qs_val(Req, <<"port">>)},
				{name, leptus_req:qs_val(Req, <<"name">>)}
			   ]]),
	Body = [{<<"callActive">>, false}],
	{ok, {json, Body}, State}.

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

post("/:ipAddress/hangup", Req, State) ->
	io:format("Received hangup request~n~p~n",
			  [[{ipAddress, leptus_req:param(Req, ipAddress)},
				{endpoint, leptus_req:body(Req)}
			   ]]),
	{no_content, <<>>, State}.


terminate(_Reason, _Route, _Req, _State) ->
    ok.
