#!/bin/env nextflow 

// Enable DSL-2 syntax
nextflow.enable.dsl=2

// Define the process
process processOne {	
	debug = true //turn to false to stop printing command stdout to screen
	// memory "50 GB"
	// cpus 56
	conda "${projectDir}/environment.yml"
	time "2h"

	// See: https://www.nextflow.io/docs/latest/process.html#inputs
	// each input needs to be placed on a new line
	input:
	path input
	path label_file
	path options_toml
	each preprocess_scheme
	each balance_scheme
	each bayescv_iteration

	// See: https://www.nextflow.io/docs/latest/process.html#outputs
	// each new output needs to be placed on a new line
	output:
	stdout
	
	// this is an example of some code to run in the code block 
	script:
	"""
	echo python3 ${projectDir}/src/train_cassifier.py \\
		--name ${params.run_name}-${preprocess_scheme}-${balance_scheme}-${bayescv_iteration} \\
		--input ${input} \\
		--labels ${label_file} \\
		--output-path . \\
		--preprocess-scheme ${preprocess_scheme} \\
		--balance-scheme ${balance_scheme} \\
		--bayescv-iterations ${bayescv_iteration} \\
		--options ${options_toml} \\
		--classifier ${params.classifier}
	"""
}