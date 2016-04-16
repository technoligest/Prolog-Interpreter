program([X])--> functionList(X).

functionList([H,T])--> function(H), functionListCollection(T).
functionListCollection([X])--> functionList(X).
functionListCollection([])--> [].
function([Ty,'(',TyL,')','=',Exp])--> typeID(Ty),['OPEN_P'],typeIDList(TyL),['CLOSE_P'],['ASSIGN'],expression(Exp).

typeID(['int', 'id'])--> ['TYPE_INT'], ['IDENTIFIER'].
typeID(['bool','id'])--> ['TYPE_BOOL'],['IDENTIFIER'].
typeIDList([H,T])-->typeID(H), typeIDListCollection(T).
typeIDListCollection([',',X])-->['COMMA'],typeIDList(X).
typeIDListCollection([])-->[].

expression(['if', Com, 'then', V1, 'else', V2])-->['COND_IF'],comparison(Com),['COND_THEN'],value(V1),['COND_ELSE'],value(V2).
expression(['let', 'id', '=', Value, 'in', Exp])-->['LET'], ['IDENTIFIER'], ['ASSIGN'], value(Value), ['LET_IN'], expression(Exp).
expression([V, E])-->value(V), extraExpression(E). 

extraExpression([A])--> arithmetic(A).
extraExpression([])-->[].

arithmetic(['+', V])-->['ARITH_ADD'],value(V).
arithmetic(['-', V])--> ['ARITH_SUB'], value(V).

comparison([V,C])-->value(V),comparisonRight(C).
comparisonRight(['==', V ])--> ['LOGIC_EQ'], value(V).
comparisonRight(['!=', V])--> ['LOGIC_NOT_EQ'], value(V).
comparisonRight(['>',V])-->['LOGIC_GT'], value(V).
comparisonRight(['>=',V])-->['LOGIC_GTEQ'],value(V).

value(['number'])-->['INTEGER'].
value(['id',V]) -->['IDENTIFIER'], valueParameters(V).
valueParameters(['(', P,')'])-->['OPEN_P'],parameters(P),['CLOSE_P'].
valueParameters([])-->[].

parameters([V , P])-->value(V), parametersList(P).
parametersList([',',P])-->['COMMA'], parameters(P).
parametersList([])-->[].