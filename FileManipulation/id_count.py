from collections import Counter
import re

'''queryid = []
keywordid = []
titleid = []
descriptionid = []
userid = []'''

d_ad_url={}
d_query={}
d_keyword={}
d_title={}
d_description={}
d_user={}
d_adid={}
d_advid={}

def open_file(file_name):
	#global queryid, keywordid, titleid, descriptionid, userid
	file = open (file_name, "r");
	for line in file:
		tuple = line.split()

		u = tuple[2]
		if u in d_ad_url:
    			d_ad_url[u] += 1
		else:
    			d_ad_url[u] = 1

		u = tuple[3]
		if u in d_adid:
    			d_adid[u] += 1
		else:
    			d_adid[u] = 1

		u = tuple[4]
		if u in d_advid:
    			d_advid[u] += 1
		else:
    			d_advid[u] = 1

		u = tuple[7]
		if u in d_query:
    			d_query[u] += 1
		else:
    			d_query[u] = 1

		u = tuple[8]
		if u in d_keyword:
    			d_keyword[u] += 1
		else:
    			d_keyword[u] = 1
   
		u = tuple[9] 
		if u in d_title:
    			d_title[u] += 1
		else:
    			d_title[u] = 1

		u = tuple[10]
		if u in d_description:
    			d_description[u] += 1
		else:
    			d_description[u] = 1

		u = tuple[-1]
		if u in d_user:
    			d_user[u] += 1
		else:
    			d_user[u] = 1
	file.close()
					
def getID_cnt(file_name):
	file_in = open(file_name, "r")
	file_out = open('id_count_'+file_name, "w")
	for line in file_in:
		line = line.split()
		ad_url = line[2]
		ad_id = line[3]
		adv_id = line[4]
		query= line[7]
		keyword = line[8]
		title = line[9]
		description = line[10]
		rest, user = ' '.join(line[:12]),line[-1]
		line = '%s %d %d %d %d %d %d %d %d\n' % (rest, d_ad_url[ad_url], d_adid[ad_id], d_advid[adv_id], d_query[query], d_keyword[keyword], d_title[title], d_description[description], d_user[user])	
		file_out.write(line)
	file_in.close()
	file_out.close()

def main():
	import sys
	#print sys.argv[1]
	if len(sys.argv) != 2:
		print("Usage: python id_count.py input_file")
		sys.exit(2)
	
	open_file(sys.argv[1])
	getID_cnt(sys.argv[1])

if __name__ == "__main__":
		main()
