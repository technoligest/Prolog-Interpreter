create_empty_table:-
	empty_assoc(X),
	b_setval(table, X).

add_symbol(Symbol, Value):-
	b_getval(table, T),
	get_check( Symbol, T, V ),
	put_assoc( Symbol, T, [Value|V], NewTable ),
	b_setval(table, NewTable).

get_check( Key, Map, Value ) :-
	get_assoc( Key, Map, Value ).
get_check( _, _, [] ).

add_symbol_list([],[]).
add_symbol_list([H|T],[H2|T2]):-
	add_symbol(H,H2),
	add_symbol_list(T,T2).

remove_symbol(Symbol):-
	b_getval(table, T),
	get_assoc(Symbol,T, [_|N]),
	put_assoc(Symbol,T,N,NewTable),
	b_setval(table,NewTable).

removeCommas([H,[]],[H|[]]).
removeCommas([H,[_,T]],[H|B]):-
	removeCommas(T,B).

initialize_functions([]).
initialize_functions([[ [[ReturnType, Name], '(', InputList,')', '=', Expression ],X ]]):-
	removeCommas(InputList, InputList2),
	add_symbol(Name, [ReturnType, InputList2, Expression]),
	initialize_functions(X).

get_symbol(Symbol, Value):-
	b_getval(table, T),
	get_assoc(Symbol, T, [Value|_]).



