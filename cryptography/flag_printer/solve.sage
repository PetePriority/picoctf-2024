import multiprocessing as mp

p = 7514777789

X = []
Y = []
for line in open('encoded.txt', 'r').read().strip().split('\n'):
    x, y = line.split(' ')
    X.append(int(x))
    Y.append(int(y))

K = GF(p)
R = PolynomialRing(K, 'x')

def compZ(X):
    x = R.gen()
    Z = K(1)
    for xk in X:
        Z *= (x-xk)
    return Z

def comp(X, Y, Xother):
    Z = compZ(Xother)
    Y = [y/Z(x) for x, y in zip(X, Y)]
    return Y, Z

def solve(X, Y):
    n = len(Y)
    print("Solving for", n, "points...")

    # just use lagrange interpolation if the degree is small enough
    if n <= 10:
        return R.lagrange_polynomial(list(zip(X, Y)))

    nhalf = n // 2

    X1 = X[:nhalf]
    Y1 = Y[:nhalf]
    X2 = X[nhalf:]
    Y2 = Y[nhalf:]

    # parallelize the computation of the two halves
    if nhalf > 10000:
        with mp.Pool(2) as pool:
            result1 = pool.apply_async(comp, (X1, Y1, X2))
            result2 = pool.apply_async(comp, (X2, Y2, X1))

            Y1, Z2 = result1.get()
            Y2, Z1 = result2.get()
    else:
        Y1, Z2 = comp(X1, Y1, X2)
        Y2, Z1 = comp(X2, Y2, X1)

    # solve recursively
    f1 = solve(X1, Y1)
    f2 = solve(X2, Y2)

    # put it back together
    return f1*Z2 + f2*Z1

def test():
    Xt = X[:1000]
    Yt = Y[:1000]
    f = solve(Xt, Yt)
    for x, y in zip(Xt, Yt):
        assert f(x) == y

test()

f = solve(X, Y)

open("output.bmp", "wb").write(bytearray(f.coefficients(sparse=False)[:-1]))
