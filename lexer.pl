:- consult('tokenizer.pl').

change('int', 'TYPE_INT').
change('bool', 'TYPE_BOOL').
change(',', 'COMMA').
change('=', 'ASSIGN').
change('let','LET').
change('in','LET_IN').
change('if', 'COND_IF').
change('then', 'COND_THEN').
change('else', 'COND_ELSE').
change('==', 'LOGIC_EQ').
change('!=', 'LOGIC_NOT_EQ').
change('>', 'LOGIC_GT').
change('>=', 'LOGIC_GTEQ').
change('+', 'ARITH_ADD').
change('-', 'ARITH_SUB').
change('(','OPEN_P').
change(')','CLOSE_P').
change(X, 'INTEGER'):-
	atom_number(X,Y), integer(Y).
change(_,'IDENTIFIER').

lexer([], []).
lexer([H|T], [Head|Rest]):-
	change(H, Head),
	!, lexer(T,Rest).

lex(Name,L):-
	tokenize_file(Name, Tok),
	!,lexer(Tok,L).