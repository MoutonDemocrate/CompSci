/**************************/
/* Definition of parent/2 */
/**************************/
parent(jack, mary).
parent(louise, jack).
parent(franck, john).
/****************************/
/* Definition of ancestor/2 */
/****************************/
ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- ancestor(X, Z), parent(Z, Y).

fact(0,1).
fact(N, Y) :- N > 0, M is N-1, fact(M,X), Y is X * N.

length_list([],0).
length_list([ _ | T ],L) :- length_list(T,M), L is M + 1.
% "Si notre peuple est immobile, ce seront les montagnes qui bougeront." - Mao Zedong

