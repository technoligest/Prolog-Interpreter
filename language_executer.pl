:-consult('interpreter.pl').

run_program( FileName, Arguments, Result ):-
	add_functions(FileName),
	call_function(Arguments, 'main', Result).
