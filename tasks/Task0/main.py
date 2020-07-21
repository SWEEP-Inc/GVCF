import json
import csv
import os
import random


def handler(event, context):
	print("Received event: " + json.dumps(event, indent=2))

	# Define number of individuals to choose from CSV
	# sample_number = 1

	#   # Get the Sample#
	# if "IND_NUM" in os.environ:
	sample_number = int(os.environ['IND_NUM'])

	# # Iterate through index list and get info for all samples
	sample_info = []
	# Index for # of individuals requested
	index = 0

	# Read in csv with information about all individuals in the given csv
	# new set file is test_issue_2.csv
	with open('all_eur_afr_pruned.csv', newline='') as csvfile:
		reader = csv.DictReader(csvfile)
		iterator = iter(reader)
		while index < sample_number:
			try:
				row = next(iterator)
			except StopIteration:
				break  # Iterator exhausted: stop the loop

			else:
				print(row['SAMPLE_NAME'], row['RUN_ID'], row['INSTRUMENT_PLATFORM'])
				pe1 = 'http://1000genomes.s3.amazonaws.com/phase3/data/' + row['SAMPLE_NAME'] + '/sequence_read/' + row[
					'RUN_ID'] + '_1.filt.fastq.gz'
				pe2 = 'http://1000genomes.s3.amazonaws.com/phase3/data/' + row['SAMPLE_NAME'] + '/sequence_read/' + row[
					'RUN_ID'] + '_2.filt.fastq.gz'
				current_sample_info = [
					{"name": "id", "value": row['SAMPLE_NAME']},
					{"name": "MYR1", "value": pe1},
					{"name": "MYR2", "value": pe2},
					{"name": "SAMPLELABEL", "value": row['RUN_ID']}]
				sample_info.append(current_sample_info)
				index = index + 1

	response = {"num_inds": sample_number,
				"env_vars" : sample_info
				}


	return response

