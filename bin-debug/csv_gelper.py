import csv

def reader(file_obj):
	reader = csv.reader(file_obj)
	wanted = []
	limit = 1000
	for row in reader:
		#print len(row)
		wanted.append(row)
		limit -= 1
		if limit == 0:
			break
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
	with open(csv_path, "rb") as f_obj:
		reader(f_obj)
