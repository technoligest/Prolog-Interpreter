:-consult('parse.pl'),consult('symbol_table.pl').

add_functions(FileName):-
	create_empty_table,
	parse(FileName,Result),
	initialize_functions(Result).

call_function(Arguments, Name, Result):-
	get_symbol(Name,[ReturnType, InputList, Expression]),
	arguments_ok(Arguments,InputList),
	expression(Expression, R),
	return_ok(ReturnType, R, Result),
	removeArguments(InputList).

return_ok('int',S,S ):-
	integer(S).
return_ok('int',S, Result):-
	atom_number(S,Result).
return_ok('bool',0,0).
return_ok('bool',1,1).


arguments_ok([],[]).
arguments_ok([H|T1],[[Type, A]|T2]):-
	integer(H),
	returntype_ok(Type,H),
	add_symbol(A,H),
	arguments_ok(T1,T2).
arguments_ok([H|T1],[[Type, A]|T2]):-
	atom_number(H,H1),
	returntype_ok(Type,H1),
	add_symbol(A,H1),
	arguments_ok(T1,T2).

returntype_ok('int',S ):-
	integer(S).
returntype_ok('bool', 0).
returntype_ok('bool', 1).

removeArguments([]).
removeArguments([[_,A]|T]):-
	remove_symbol(A),
	removeArguments(T).



expression(['if', Comparison,'then',V1,'else', _ ], Result):-
	compareH(Comparison, C),
	C==1,
	valueH(V1, Result).
expression(['if', _,'then',_,'else', V2 ], Result):-
	valueH(V2, Result).

expression(['let',Id, '=', Value,'in',Expression],Result):-
	valueH(Value, VR),
	add_symbol(Id, VR),
	expression(Expression,Result),
	remove_symbol(Id).
expression(Arithmetic, Result):-
	arithH(Arithmetic, Result).

findF(1,V,_,V).
findF(0,_,V,V).

compareH([Value,CompRight], Result):-
	valueH(Value, V1R),
	compareRightH(CompRight,[Operator,V2Result]),
	compare(Operator,V1R,V2Result,Result).
compareRightH([Op,Value],[Op,ValueResult]):-
	valueH(Value,ValueResult).
compare('==', A,A,1).
compare('!=',A,B,1) :- A \= B.
compare('>',V1,V2,1) :- V1 > V2.
compare('>=',V1,V2,1) :- V1 >= V2.
compare( _, _, _, 0 ).

valueH([N],N).
valueH([A,[]],Result):-
	get_symbol(A,Result).
valueH([Id,Vparam],Result):-
	vparamH(Vparam,VPResult),
	valueEval(Id,VPResult,Result).

vparamH(['(',[H|X],')'], [HVal|T]):-
	valueH(H, HVal),
	%write(HVal),nl,
	genParam(X, T).

genParam([[]],[]).
genParam([[',' , [A|B] ]], [Aval|Z]):-
	valueH(A, Aval),
	genParam(B, Z).

valueEval(Id,[],Result):-
	get_symbol(Id,Result).
valueEval(Id,Param,Result):-
	call_function(Param,Id,Result).





arithH([Value,[]],Result):-
	valueH(Value, Result).
arithH([Value,Extra], Result):-
	valueH(Value, V1R),
	arithRightH(Extra,[Operator,V2Result]),
	arith(Operator,V1R,V2Result,Result).

arithRightH([],[]).
arithRightH([[Op,Value]],[Op,ValueResult]):-
	valueH(Value,ValueResult).

arith('+',V1,V2,R):-
	R is V1+V2.
arith('-',V1,V2,R):-
	R is V1-V2.








