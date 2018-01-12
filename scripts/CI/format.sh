#!/bin/sh
if [[ ! -z "$(python2.7 -m flake8 --ignore E731 --exclude=./deprecated,./gnc/navigator_path_planner/lqRRT,__init__.py --max-line-length=120 .)" ]]; then
	echo "The preceding Python files are not formatted correctly"
	exit 1
fi

source /opt/ros/kinetic/setup.bash > /dev/null 2>&1
wget -O ~/.clang-format https://raw.githubusercontent.com/uf-mil/installer/master/.clang-format
for FILE in $(find -path ./deprecated -prune -o -regex ".*/.*\\.\\(c\\|cc\\|cpp\\|h\\|hpp\\)$"); do
	if [ ! -z "$(clang-format-3.8 -style=file -output-replacements-xml $FILE | grep '<replacement ')" ]; then
		FILES+=( "$FILE" )
	fi
done
if (( ${#FILES[@]} > 0 )); then
	echo "The C++ following files are not formatted correctly: ${FILES[@]}"
	exit 1
fi