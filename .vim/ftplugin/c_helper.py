import subprocess
import os
import sys
import re

from os.path import isfile, join
from os import listdir

cwd = os.environ.get("PWD")
filename = sys.argv[1]

def do_make(makefile_path):
  dir, file = os.path.split(makefile_path)
  with open(makefile_path, 'r') as makefile:
      for line in makefile:
          m = re.match("NAME:=([a-z_]+)", line, re.MULTILINE)
          if m:
              name = m.group(1)
  print ("running Make")
  if dir:
    os.chdir(dir)

  cmd = "make -f {0} -j7".format(file)
  print cmd
  status = os.system(cmd)
  if status == 0:
      if name:
          print(("Running %s" % name))
          ret = os.system("./%s" % name)
          print ("({})".format(ret))
          sys.exit(0)
  else:
      print("Make failed")
      sys.exit(-1)


files = [f for f in listdir(cwd)]


if 'build' in files:
  files = [f for f in listdir(cwd)]
  if 'Makefile' in files:
    print "build directory exists"
    print os.getcwd()
    do_make('build/Makefile')
    sys.exit(0)
  elif 'build.ninja' in files:
    print "Ninja file exists"
    sys.exit(0)
elif "Makefile" in files:
  do_make("Makefile")
elif "config.yaml" in files:
  status = os.system("clyde test")
  sys.exit(status)


prefix, extension = os.path.splitext(filename)

compilers_by_extension = {'.cpp'   : 'g++',
                          '.cc'    : 'g++', 
                          '.c'     : 'gcc'}

flags_by_compiler = {'g++' : '--std=c++11',
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
print(("Compiling %s" % filename))
print (command)
status = os.system(command)
print (status)
if status == 0: 
    print(("Running %s.out" % filename))
    os.system("./%s" % filename + ".out")
    os.unlink("./%s" % filename + ".out")
else:
    print ("Compilation Failed")
