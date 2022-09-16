import csv

def read_csv_file(filename):
    data = []
    filename = '../' + filename
    with open(filename) as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            data.append(row)
    return data

data = read_csv_file('TestData/CsvFiles/Data.csv')
'''
    row = 0
    data_1 = testdata[row][0]
    data_2 = testdata[row][1]
    data_3 = testdata[row][2]
'''
