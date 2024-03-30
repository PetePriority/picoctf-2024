In this challenge we are provided with ssh access to a shell with a twist: We can't use any letters.

We execute `$-` and pipe stderr to stdout. `$-` gives the flags that are set in bash:
```
SansAlpha$ $-
bash: himBHs: command not found
```

From this, we try to construct the `id` command. First, we pipe stderr to stdout: `"$($- 2>&1)"`. This will run "bash: himBHs: command not found"

We can use the `$_` variable, to access the last command that was run. So, to run `id`, we do:
```
SansAlpha$ "$($- 2>&1)"; ${_:7:1}${_:20:1};
=> uid=1000(ctf-player) gid=1000(ctf-player) groups=1000(ctf-player)
```

From this, we get `ls`:
```
SansAlpha$ "$($- 2>&1)"; "$(${_:7:1}${_:20:1})"; ${_:14:1}${_:47:1}
blargh    on-calastran.txt
```

From this, we get `cat` and `on-calastran.txt`:
```
SansAlpha$ "$($- 2>&1)"; "$(${_:7:1}${_:20:1})"; "$(${_:14:1}${_:47:1})"; ${_:10:1}${_:11:1}${_:15:1} ${_:7:16}
The Calastran multiverse is a complex and interconnected web of realities, each
with its own distinct characteristics and rules. At its core is the Nexus, a
cosmic hub that serves as the anchor point for countless universes and
dimensions. These realities are organized into Layers, with each Layer
representing a unique level of existence, ranging from the fundamental building
blocks of reality to the most intricate and fantastical realms. Travel between
Layers is facilitated by Quantum Bridges, mysterious conduits that allow
individuals to navigate the multiverse. Notably, the Calastran multiverse
exhibits a dynamic nature, with the Fabric of Reality continuously shifting and
evolving. Within this vast tapestry, there exist Nexus Nodes, focal points of
immense energy that hold sway over the destinies of entire universes. The
enigmatic Watchers, ancient beings attuned to the ebb and flow of the
multiverse, observe and influence key events. While the structure of Calastran
embraces diversity, it also poses challenges, as the delicate balance between
the Layers requires vigilance to prevent catastrophic breaches and maintain the
cosmic harmony.
```

And we have lots of letters (except the letter `j`)!

The provided `solve.py` can generate the remaining commands needed to solve the challenge (`ls blargh`, and `cat blargh/flag.txt`):
```
ls blargh:
"$($- 2>&1)"; "$(${_:7:1}${_:20:1})"; "$(${_:14:1}${_:47:1})"; "$(${_:10:1}${_:11:1}${_:15:1} ${_:7:16})"; ${_:6:1}${_:8:1} ${_:59:1}${_:6:1}${_:5:1}${_:10:1}${_:262:1}${_:1:1}
cat blargh/flag.txt
"$($- 2>&1)"; "$(${_:7:1}${_:20:1})"; "$(${_:14:1}${_:47:1})"; "$(${_:10:1}${_:11:1}${_:15:1} ${_:7:16})"; ${_:30:1}${_:5:1}${_:9:1} ${_:59:1}${_:6:1}${_:5:1}${_:10:1}${_:262:1}${_:1:1}/${_:62:1}${_:6:1}${_:5:1}${_:262:1}.${_:9:1}${_:36:1}${_:9:1}
