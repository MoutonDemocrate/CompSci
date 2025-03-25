listing(pose/2).

pose(c,table).
pose(b,c).
pose(a,b).

couvert(table) :- false.
couvert(X) :- pose(Y,X).