1.  Compile the dependencies and the package


        $ ./rebar get-deps compile

2.  Run

Run in shell

        $ sh run

Alternativly Compile and run

        $ sh compilerun


http requests:

        <serverip>:10111/esi/esi_facade:place_bet?user=<username>&password=<password>&country=<country>&hour=<hour>&minute=<minute>&targetstatus=<happier/sadder>&credits=<credits to bet>
        <serverip>:10111/esi/esi_facade:register_user?user=<username>&password=<password>
        <serverip>:10111/esi/esi_facade:login?user=<username>&password=<password>
        <serverip>:10111/esi/esi_facade:get_all_bets?user=<username>&password=<password>
        <serverip>:10111/esi/esi_facade:get_user_credits?user=<username>&password=<password>
        <serverip>:10111/esi/esi_facade:current_happiness?apikey=<apikey>

## Dependencies

### [erlang-oauth](https://github.com/tim/erlang-oauth/)

erlang-oauth is used to construct signed request parameters required by OAuth.

### [ibrowse](https://github.com/cmullaparthi/ibrowse)

ibrowse is an HTTP client allowing to close a connection while the request is still being serviced. We need this for cancelling Twitter streaming API requests.

### [jiffy](https://github.com/davisp/jiffy)

jiffy is a JSON parser, which uses efficient C code to perform the actual parsing. [mochijson2](https://github.com/bjnortier/mochijson2) is another alternative that could be used here.

## Based on  dit029-twitter-miner by Michal Palka

Fork of derrivation: https://github.com/davidkron/dit029-twitter-miner

* Michal Palka (michalpalka) <michal.palka@chalmers.se>

