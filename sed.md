# Change text with sed

## This will print the change but won't execute it on the file
sed 's/origin/changed/' <filename>

## This will actually change the file and create a backup appending the '.old'
## -i stands for "in-place"
sed -i '.old' 's/origin/changed/' <filename>

## This will actually change the file without backup
sed -i '' 's/origin/changed/' <filename>

## trick to replace all instances in a specific grep find
grep -l -s -R cryptography==1.3.1 * | xargs sed -i '' 's/cryptography==1.3.1/cryptography==1.7.1/'
