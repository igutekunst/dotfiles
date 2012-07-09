import subprocess
import os
import sys

cwd = os.environ.get("PWD")
print cwd
if "advanced_c" in cwd:
  (up,right) = os.path.split(cwd)
  (up,right) = os.path.split(up)
  os.chdir(up)
  print os.getcwd()
  f = open("usersrc",'w')
  full_path = os.path.join(cwd,sys.argv[1])
  f.write("USERSRC = %s\n"%full_path)
  f.close()
  print os.system("make simulate")
  print os.system("./client")
  #subprocess.call("make program", shell=True)
elif "design_principles" in cwd:
  (up,right) = os.path.split(cwd)
  (up,right) = os.path.split(up)
  os.chdir(up)
  print os.system("make simulate")
  print os.system("./client")
  #subprocess.call("make program", shell=True)
