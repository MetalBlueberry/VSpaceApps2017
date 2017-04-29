import sys
import os
import os.path
if(len(sys.argv)!=2):
    print("Necesito el direcctorio debug")
    quit()
if(os.path.exists( sys.argv[1] + "qrc_resources.cpp")):
    os.remove(sys.argv[1] + "qrc_resources.cpp")
    print("OK")
quit()
# "%{sourceDir}\clean.py"  %{buildDir}\debug\
