This challenge is about RSA. We are given the ciphertext $C$ of a password that we need to decrypt the flag, as well as an oracle, that can encrypt and decrypt anything but the password.

The idea here is to ask the oracle to decrypt $C_a\cdot C$ for some specifically chosen ciphertext $C_a$. [This](https://crypto.stackexchange.com/a/2331) stackexchange answer explains the attack in detail.

The main idea is to ask the oracle to decrypt the product of the ciphertext $C$ with the ciphertext $C_a \equiv 2^e\mod n$ of some known and small number, in this case we chose 2. Then, since $(x^e)^d \equiv x \mod n$,
```math
\begin{align*}
(C\cdot C_a)^d &\equiv (2^e\cdot t^e)^d&\mod n \\
            &\equiv 2\cdot t&\mod n
\end{align*}
```

So all that's left to do to retrieve the password is to divide the returned plaintext by 2.