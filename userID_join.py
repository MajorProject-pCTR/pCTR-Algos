file_in = open("userid_profile.txt","r")
max_freq = []
arr1 = []
arr2 = []

for line in file_in:
	cols = line.split()
	arr1.append(cols[1])
	arr2.append(cols[2])

from collections import Counter 

count1 = Counter (arr1)
count2 = Counter (arr2)

print 'Most common (field 1): \n' + str(count1.most_common()[0])
print 'Second most common (field 1): \n' + str(count1.most_common()[1])
print 'Most common (field 2): \n' + str(count2.most_common()[0])
print 'Second most common (field 2): \n' + str(count2.most_common()[1])