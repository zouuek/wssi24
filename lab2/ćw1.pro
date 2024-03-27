
lubi(adrian,darek).
lubi(adrian,marek).
lubi(marek,rudy).
lubi(rudy,marek).
lubi(jan,pawel).
lubi(pawel,jan).
lubi(marek,adrian).
lubi(xd, xxdd).
lubi(xxdd, xd).

kobieta(xxdd).
kobieta(xd).
kobieta(pawel).

mezczyzna(jan).


przyjazn(X,Y):-
    lubi(X,Y),
    lubi(Y,X).

nibyprzyjazn(X,Y):-
    lubi(X,Y);
    lubi(Y,X).

nieprzyjazn(X,Y):-
    \+lubi(X,Y),
    \+lubi(Y,X).

loves(X,Y):-
    przyjazn(X,Y),(\+ ((lubi(X,Z)),(Z\=Y))).

truelove(X,Y):-
    loves(X,Y),
    (kobieta(X), mezczyzna(Y);
    	mezczyzna(X), kobieta(Y)).
