:- consult('lexer.pl'), consult('grammar.pl').

parse(FileName, Result):-
	tokenize_file(FileName, TokenList),
	lexer(TokenList, LexedList),

	phrase(program(StructuredList),LexedList ),
	substitudeVariables(TokenList, StructuredList,[],Result).



substitudeVariables(A,[],A,[]).
substitudeVariables([H|T],[H1|T1],A,[H|T2]):-
	atomic(H1),
	 substitudeVariables(T,T1,A,T2).
substitudeVariables(TokenList,[H1|T1],A,[H|T2]):-
	 substitudeVariables(TokenList,H1,N,H),
	 substitudeVariables(N,T1,A,T2).


	


