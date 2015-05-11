import sys
if len(sys.argv) != 2:
        sys.exit("Usage: python token_count.py inputfile")

inputfile = sys.argv[1]
outputfile = "tcnt_" + inputfile

in_file = open(inputfile,"r")
out_file = open(outputfile,"w")
for line in in_file :
	id = line.split()[0]
	count = len(line.split("|"))
	out_file.write(str(id)+"\t"+str(count)+"\n")

print(outputfile + " successfully created")

in_file.close()
out_file.close()
