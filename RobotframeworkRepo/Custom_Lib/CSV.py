import csv
import os.path

def read_csv_file(filename):
    data = []
    with open(filename, 'rb') as csvfile:
        reader = csv.reader(csvfile)
        for row in reader:
            data.append(row)
    return data

def write_into_csv(filename, items):
    file_exists = os.path.isfile(filename)

    file = open(filename, 'a')
    with file:
        # identifying header
        header = ['Date','TestName', 'UIMessage',
                  'DBMessage', 'JobUUID', 'FileStatus']
        writer = csv.DictWriter(file, fieldnames=header)
        if not file_exists:
            writer.writeheader()
        writer.writerow(items)

