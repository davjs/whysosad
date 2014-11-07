-module(esi_facade).
-export([current_happiness/3,happiness_change/3]).

current_happiness(Sid, Env, In) -> 
Map = database:getMap(),
Countries = maps:keys(Map),
KeyValues = ["\"" ++ Country ++ "\"" ++ "\: " ++ integer_to_list(maps:get(Country,Map))|| Country<-Countries],
Json = "{" ++ string:join(KeyValues,",") ++ "}",
mod_esi:deliver(Sid,Json).

happiness_change(Sid, Env, In) -> mod_esi:deliver(Sid, ["{\"Sweden\":-5,\"Denmark\":200,}"]).
