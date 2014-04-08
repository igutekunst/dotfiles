import subprocess
import os
import sys
import re

from os.path import isfile, join
from os import listdir

cwd = os.environ.get("PWD")
filename = sys.argv[1]


files = [f for f in listdir(cwd) if isfile(join(cwd, f))]

if "Makefile" in files:
    with open("Makefile", 'r') as makefile:
        for line in makefile:
            m = re.match("NAME:=([a-z_]+)", line, re.MULTILINE)
            if m:
                name = m.group(1)
    print ("running Make")
    os.system("make")

    if name:
        print ("Running %s" % name)
        os.system("./%s" % name)
    sys.exit(0)


prefix, extension = os.path.splitext(filename)

compilers_by_extension = {'.cpp'   : 'g++',
                          '.cc'    : 'g++', 
                          '.c'     : 'gcc'}

flags_by_compiler = {'g++' : '--std=c++0x',
                     'gcc' : '--std=c99'}



if extension in compilers_by_extension:
    compiler = compilers_by_extension[extension]
else:
    raise Exception("Extension %s not supported", extension)

flags =  flags_by_compiler[compiler]

command = "%s %s %s -o %s" % (compiler, 
                              filename, 
                              flags,
                              filename  + ".out")
print ("Compiling %s" % filename)
print (command)
if os.system(command) == 0:
    print ("Running %s.out" % filename)
    os.system("./%s" % filename + ".out")
    os.unlink("./%s" % filename + ".out")
else:
    print ("Compilation Failed")
