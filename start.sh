#!/bin/sh

rebar get-deps && rebar compile && erl -pa ebin deps/*/ebin -s mesh
