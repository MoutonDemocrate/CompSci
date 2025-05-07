:- include(libtp2).

def_var([],[],_).
def_var([Xt|Xq],[Tt|Tq]):-
	borneTi is T-Tq,
	fd_domain(Xt,0,borneTi),
	def_var(Xq,Tq,T).

solve(Num, Xs, Ys):-
	