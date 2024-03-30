We are given a file containing $n+1=1769611$ pairs of integer pairs $(x_i.y_i)$ and a python script called `flag_printer.py`.

The python script loads the pairs of points and tries to solve the linear system of equation
$$Ap = y$$
where the matrix $A$ is the Vandermonde matrix
```math
\begin{pmatrix}
  1      & x_0    & x_0^2  & \cdots & x_0^{n} \\
  1      & x_1    & x_1^2  & \cdots & x_1^{n} \\
  1      & x_2    & x_2^2  & \cdots & x_2^{n} \\
  \vdots & \vdots & \vdots & \ddots & \vdots    \\
  1      & x_{n}    & x_{n}^2  & \cdots & x_{n}^{n}
\end{pmatrix}
```
using `numpy.linalg.solve`. The first problem with this approach is the size of the matrix $A$, since it consists of $(n-1)^2 \approx 3*10^{12}$ elements which would be way too big. The second problem would be the runtime, as the complexity of solving this system is around $O(n^3)$.

Because of the special form of the matrix, however, this is not a generic system of linear equations. This problem is in fact equivalent to finding a polynomial
$$p(x) = a_0 + a_1x + \ldots a_nx^n$$
of degree $n$, such that $p(x_i) = y_i$. The coefficients $a_i$ then are just the components of the solution $p$ to $Ap=y$.

There are algorithms to compute the coefficients given the pairs $(x_i, y_i)$ but the complexity is still $O(n^2)$ and would take too long to compute.

However, we can use the following ansatz and apply the divide and conquer method of the FFT algorithm to reduce the complexity further to $O(n\log n)$.

Let $m = \lfloor n/2\rfloor$ (n/2 rounded down) and define the polynomials
$$Z_1(x) = \Pi_{k=0}^m (x-x_k) \quad\text{and}\quad Z_2(x) = \Pi_{k=m+1}^n (x-x_k).$$
We note that $Z_1(x_k) = 0$ for $k \in \{0, \ldots, m\}$ and $Z_2(x_k) = 0$ for $k\in\{x_{m+1},\ldots,x_n\}$.

We can now write
$$f = f_1Z_2 + f_2Z_1$$
for some polymials $f_1$ and $f_2$ of half the degree of $f$. Furthermore, since $f(x_k) = y_k$ and since $Z_1$ and $Z_2$ vanish on the first and second half of the $x_k$, respectively, we have
```math
f_1(x_k) = \frac{y_k}{Z_2(x_k)}, \text{for $k\in\{0, \ldots, m\}$}
```
```math
f_2(x_k) = \frac{y_k}{Z_1(x_k)}, \text{for $k\in\{m+1,\ldots,n\}$}.
```
Hence, we can now solve for $f_1$ and $f_2$ using interpolation of half the size, and apply the same approach again.

The provided `solve.sage` needs to be run in with [sage](https://www.sagemath.org/).
