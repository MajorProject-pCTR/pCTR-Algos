from collections import Counter
import re


userid = []
d={}

def open_file():
	global userid
	file = open ("test_sub.txt", "r");
	for line in file:
		tuple = line.split()
		userid.append(tuple[-1]) 
	file.close()

def getFreq():
	
	'''cnt = Counter(userid)
	freqList = sorted(cnt.iteritems())
	return freqList'''
	for u in userid:
		if u in d:
    			d[u] += 1
		else:
    			d[u] = 1

def replaceID(freqList):
	file_in = open("test_sub.txt", "r")
	file_out = open("test_userid.txt", "w")
	for line in file_in:
		line = line.split()
		rest, user = ' '.join(line[:11]),line[-1]
		if user in d:
			line = '%s %d\n' % (rest, d[user])	
		file_out.write(line)
	file_in.close()
	file_out.close()

def main():
	open_file()
	freqList = getFreq()
	replaceID(freqList)

if __name__ == "__main__":
		main()
