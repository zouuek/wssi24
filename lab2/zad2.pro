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


rodzic(marcin,gosia).
rodzic(monika,gosia).
rodzic(monika,jan).
rodzic(marcin,jan).
rodzic(tomek,dawid).
rodzic(gosia,dawid).
rodzic(jan,pawel).
rodzic(aska,pawel).


kobieta(X):-
    (   osoba(X), (\+mezczyzna(X)) ).

ojciec(X,Y):- % X jest ojcem Y
    mezczyzna(X), rodzic(X,Y), osoba(X), osoba(Y).

matka(X,Y):- % X jest matką Y
    kobieta(X), rodzic(X,Y), osoba(X), osoba(Y).

corka(X,Y):- %X jest córką Y
    kobieta(Y), rodzic(X,Y), osoba(X).

brat_rodzony(X,Y):- % X jest rodzonym bratem Y
    mezczyzna(X), matka(Z,X), matka(Z,Y),
    ojciec(O,X), ojciec(O,Y), osoba(X), osoba(Y), X\=Y.

brat_przyrodni(X, Y):- % X jest przyrodnim bratem Y
    mezczyzna(X), osoba(X), osoba(Y),
    (   
    	ojciec(O,X), ojciec(O,Y),
        (   matka(M,X), \+matka(M,Y))
    );
    (   matka(M,X), matka(M,Y),
        (   ojciec(O,X), \+ojciec(O,Y))
    ).
kuzyn(X,Y):- %x kuzynem y
    babcia(Z,X), babcia(Z,Y), dziadek(O,X), dziadek(O,Y), matka(M,X), \+(matka(M,Y)), ojciec(P,X), \+(ojciec(P,Y)), mezczyzna(X).
	
dziadek_od_strony_ojca(X,Y):- % X jest dziadkiem od strony ojca dla Y
    ojciec(X,Z), ojciec(Z,Y).

dziadek_od_strony_matki(X,Y):- % X jest dziadkiem od strony matki dla Y
    ojciec(X,Z), matka(Z,Y).

dziadek(X,Y):- % X jest dziadkiem Y
    once(dziadek_od_strony_matki(X,Y); dziadek_od_strony_ojca(X,Y)). %za pomocą once operator or zwraca tylko jedną wartość zamaist kilku

babcia(X,Y):- % X jest babcią Y
    once(   (   
    	matka(X,Z), ojciec(Z,Y)
    );
    (   matka(X,Z), matka(X,Z)
    )).
wnuczka(X,Y):- % (   Y jest wnuczką X)
	once(babcia(X,Y); dziadek(X,Y)), kobieta(Y).

przodek_do2pokolenia_wstecz(X,Y):- %X jest przodkiem Y
    once(rodzic(X,Y); dziadek(X,Y); babcia(X,Y)).

przodek_do3pokolenia_wstecz(X,Y):- % X przodkiem Y
    once((przodek_do2pokolenia_wstecz(X,Y));( rodzic(X,Z), przodek_do2pokolenia_wstecz(Z,Y))).










