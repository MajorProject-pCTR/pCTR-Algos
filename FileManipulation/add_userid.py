d_userid={}

def get_userid(file_name):

	file = open("userid_profile.txt", "r");
	for line in file:
		tuple = line.split()
		u = tuple[0]

		if u not in d_userid:
			d_userid[u] = 1
	file.close()


	file = open(file_name, "r");
	for line in file:
		tuple = line.split()

		u = tuple[11]

		if u not in d_userid:
			d_userid[u] = 0
	file.close()

				
def getID_cnt():
	file_out = open("userid_profile.txt", "a")
	
	for u in d_userid:
		if d_userid[u]==0:
			line = '%s\t%s\t%s\n' % (u, 0, 0)
			file_out.write(line)

	file_out.close()


def main():
	import sys
	if len(sys.argv) != 2:
		print("Usage: python add_userid.py input_file")
		sys.exit(2)
	
	get_userid(sys.argv[1])
	getID_cnt()

if __name__ == "__main__":
		main()
