tokenize_file(Filename, TokenList):-
	open(Filename, read, Stream),
	get0(Stream, T),
	read_word(Stream,T,InputList),
	removeSpaces(InputList, NoSpaceList),
	atom_codes(TokenString, NoSpaceList),
	!, atomic_list_concat(TokenList, ' ',TokenString).

read_word(_, -1,[]).
read_word(_, end_of_file,[]).
read_word(Stream,Char, [Char|Content]):-
	get0(Stream, Val),
	read_word(Stream, Val, Content).

removeSpaces([], []).
removeSpaces([9|Tail], [32|NewList]):-
	!, removeS(Tail, New),
	!, removeSpaces(New, NewList).
removeSpaces([10|Tail], [32|NewList]):-
	!, removeS(Tail, New),
	!, removeSpaces(New, NewList).
removeSpaces([13|Tail], [32|NewList]):-
	!, removeS(Tail, New),
	!, removeSpaces(New, NewList).
removeSpaces([32|Tail], [32|NewList]):-
	!, removeS(Tail,New),
	!, removeSpaces(New, NewList).
removeSpaces([Head|Tail], [Head|NewList]):-
	!, removeSpaces(Tail, NewList).

removeS([],[]).
removeS([9|Tail],NewList):-
	!, removeS(Tail, NewList).
removeS([10|Tail],NewList):-
	!, removeS(Tail, NewList).
removeS([13|Tail],NewList):-
	!, removeS(Tail, NewList).
removeS([32|Tail],NewList):-
	!, removeS(Tail,NewList).
removeS([Head|Tail],[Head|Tail]).