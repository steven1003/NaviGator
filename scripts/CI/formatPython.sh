#!/bin/sh
if [[ ! -z "$(python2.7 -m flake8 --ignore E731 --exclude=./deprecated,./gnc/navigator_path_planner/lqRRT,__init__.py --max-line-length=120 .)" ]]; then
	echo "The preceding Python files are not formatted correctly"
	exit 1
fi