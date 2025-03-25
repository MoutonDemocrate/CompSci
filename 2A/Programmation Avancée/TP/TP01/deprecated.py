import functools

def deprecated(f):
	@functools.wraps(f)
	def f_interne(*p, **kw):
		print("La fonction", f.__qualname__, "ne devrait plus être utlisée...")
		f(*p,**kw)
	return f_interne

@deprecated
def stupid(strogan,beef,imoff):
	print("she", strogan,"on my",beef,"till",imoff)

stupid("uncons","flux","monade")