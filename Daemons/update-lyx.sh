#!/usr/bin/env bash

# This is a script meant to run in the background and compile any LyX file nested in the home directory (excluding dotfiles)
# to pdf (as a file with an identical basename, changing the lyx extension to pdf). This means I can see output continously and
# not need to

files=$(find ~/Projects -mindepth 1 -maxdepth 1 -not -name "FILER" -a -not -name ".git") # All project folders ecvluding ACCESS (as Google Drive mount makes a mess), space delimited
files="$files $(find ~/Projects/FILER -mindepth 1 -maxdepth 1 -type d -and -not -name "Drive" -and -not -name "Phone" -and -not -name "Windows" -and -not -name "Linux" -or -name "*.lyx")" # Add ACCESS subdirectories, excluding the aforementioned drive mount
count=0 # count of files compiles, so I can make distinct log files for each one.

# Run whenever a LyX file nested in the home directory is saved, and keep an iteration variable for its path.
# -r : Recurse through the directories to find any nested files
# -m : Run continously whenever an event occurs
# --include : Watch only LyX files, by extension
# --format : output only full file path
# -e : monitor move events - upon save, lyx creates a temporary file then moves it to the original file's pathchk
# $files : look only in the project directories, as listed.
# read : Keep the file path putput in an iteration variable file path
inotifywait -m -r --include '\.lyx$' --format "%w%f" -e moved_to $files | while read file_path
do
	# If the file requires shell-escaped compilation (which lyx -e pdf can't do), export to latex and compile manually
	if [ -n "$(cat "$file_path" | grep -x ".\\usepackage{minted}")" ] || [ -n  "$(cat "$file_path" | grep -x ".\\write18")" ]; then

		echo "UPDATED: $file_path, with shell escape"

		output_dir=/tmp/lyx-export-$count
		mkdir -p "$output_dir"
		echo "Created output dir: $output_dir"

		tex_path="$output_dir/$count.tex"
		# lyx -E export to a specific file path
		lyx -E latex  "$tex_path" "$file_path"
		cd "$output_dir"
		# Need to compile twice to use generated bookmark metadata with hyperref.
		pdflatex -shell-escape "$tex_path" > "$count-log.txt" 2>&1
		pdflatex -shell-escape "$tex_path" > "$count-log.txt" 2>&1
		echo "Compiled pdf, log written to $count-log.txt"

		# Check that a file was generated and that it is indeed newer than the current pdf compilation
		if [ -f "$count.pdf" ] && [ "$count.pdf" -nt "$pdf_path" ]; then
			echo "Operation Succesful!"
			pdf_path="${file_path%.*}.pdf"
			mv "$count.pdf" "$pdf_path"
			echo "Moved PDF file back to place."
		else
			echo "Operation failed. See log file for details"
		fi

	else
		echo "UPDATED: $file_path, normal file"
		lyx -e pdf "$file_path" > /tmp/lyx-export-$count.log 2>&1 && echo "Operation succeful!" || echo "Operation Failed"
		echo "log written to /tmp/lyx-export-$count.log"
	fi

	((count=count+1))
done
