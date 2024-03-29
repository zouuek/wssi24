osoba(jan).
osoba(pawel).
osoba(magda).
osoba(monika).
osoba(marek).
osoba(marcin).
osoba(gosia).
osoba(patrycja).
osoba(tomek).
osoba(aska).
osoba(dawid).

mezczyzna(jan).
mezczyzna(pawel).
mezczyzna(marek).
mezczyzna(marcin).
mezczyzna(tomek).
mezczyzna(dawid).

rodzic(jan,aska).
rodzic(jan,dawid).
rodzic(monika,dawid).
rodzic(magda,aska).

rodzic(jan,pawel).
rodzic(jan,magda).
rodzic(monika,magda).
rodzic(monika,pawel).
rodzic(pawel,marcin).
rodzic(jan,tomek).
rodzic(monika,tomek).

kobieta(X):-
    (   osoba(X), (\+mezczyzna(X)) ).

ojciec(X,Y):-
    mezczyzna(X), rodzic(X,Y), osoba(X), osoba(Y).

matka(X,Y):-
    kobieta(X), rodzic(X,Y), osoba(X), osoba(Y).

corka(X,Y):-
    kobieta(Y), rodzic(X,Y), osoba(X).

brat_rodzony(X,Y):-
    mezczyzna(X), matka(Z,X), matka(Z,Y),
    ojciec(O,X), ojciec(O,Y), osoba(X), osoba(Y), X\=Y.

brat_przyrodni(X, Y):-
    mezczyzna(X), osoba(X), osoba(Y),
    (   
    	ojciec(O,X), ojciec(O,Y),
        (   matka(M,X), \+matka(M,Y))
    );
    (   matka(M,X), matka(M,Y),
        (   ojciec(O,X), \+ojciec(O,Y))
    ).
kuzyn(X,Y):-
    
                  

    

