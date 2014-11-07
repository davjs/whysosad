%%%-------------------------------------------------------------------
%%% @author David
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. okt 2014 07:08
%%%-------------------------------------------------------------------
-module(database).
-author("David").

-export([start/0,stop/0,getData/1,setData/2,getMap/0]).


start() ->
  Registered = whereis(sts) =/= undefined,
  if
    Registered -> {ok,whereis(sts)}; % If started, return the process id
    not Registered -> Pid = spawn(fun () -> init() end), %If not started, spawn Init and register
      register(sts,Pid), {ok,Pid}
  end.

stop() ->
  Registered = whereis(sts) =/= undefined,
  if
    Registered -> sts ! {stop,self()}, receive stopComplete->stopped end;
    not Registered -> already_stopped
  end.

getData(Key) ->
  sts ! {get,self(),Key},
  receive
    {getAnswer,Value} -> Value
  end.

getMap()->
  sts ! {getMap,self()},
  receive
    {getMapAnswer,Map} -> Map
  end.

setData(Key,Value) -> sts ! {set,self(),Key,Value} ,ok.

init()-> sts ! print,loop(maps:new()).

print(Map)->
  io:format("\e[H\e[J"),
  Countries = maps:keys(Map),
  [io:format(lists:append(Country ++ "\: " ++ integer_to_list(maps:get(Country,Map)),"\t"))
    || Country<-Countries].

loop(Map) ->
  receive
    {getMap, Pid} -> Pid ! {getMapAnswer,Map},loop(Map);
    {stop,Pid} -> Pid ! stopComplete;
    {set,Pid,Key,Value} -> loop(maps:put(Key,Value,Map)); % Put the Value(Map List or Variable) in the big map
    {get,Pid,Key} -> Pid ! {getAnswer,maps:get(Key,Map,0)}, loop(Map)
    after 200 ->
      print(Map),loop(Map)
  end.
