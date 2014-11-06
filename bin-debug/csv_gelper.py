import csv

def reader(file_obj):
	reader = csv.reader(file_obj)
	wanted = []
	limit = 200
	index = 0
	avg = (42001/9)
	for row in reader:
		#print len(row)
		index += 1
		if index < 200:
			print row[0]
			wanted.append(row)
		if index == avg:
			index = 0	
	writer(wanted)

def writer(wanted):
	with open("t.csv", "wb") as csv_file:
		writer = csv.writer(csv_file, delimiter = ',')
		#print wanted[0]
		for line in wanted:
			#print line[0]
			writer.writerow(line)

if __name__ == "__main__":
	csv_path = "train.csv"
	with open(csv_path, "r") as f_obj:
		reader(f_obj)
