-module(main).

% exports methods of this module
% like this [...method/count_of_arg]

-export([get_users/0,get_males/1,split_by_age/1 , get_id_name/1]).

get_users()->
    [{user,1,'Bob',male,33},
     {user,2,'Helen',female,13},
     {user,3,'Bill',male,10},
     {user,2,'Kate',female,18}].


get_males(Users) -> get_males(Users,[]).

get_males([],Acc) -> lists:reverse(Acc);

get_males([User | Rest], Acc) -> 
    case User of
        { user, _,_, female} -> get_males(Rest,Acc);
        {user, _,_, male} -> get_males(Rest, [User | Acc])
    end.

split_by_age(Users) -> split_by_age(Users, {[], []}).

split_by_age([],{Acc1,Acc2}) -> {lists:reverse(Acc1), lists:reverse(Acc2)};

split_by_age([User | Rest], {Acc1,Acc2}) -> 
    {user, _, _, _,Age} = User,
    if
        Age < 18 -> split_by_age(Rest, {[User | Acc1], Acc2});
        true -> split_by_age(Rest, {Acc1,[User | Acc2]})
    end.

get_id_name(Users) -> get_id_name(Users, []).

get_id_name([], Acc) -> lists:reverse(Acc);

get_id_name([User | Rest], Acc) ->
    {user , Id, Name, _, _} = User,
    get_id_name(Rest, [{Id,Name} | Acc]).