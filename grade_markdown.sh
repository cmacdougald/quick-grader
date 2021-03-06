#/bin/bash
sudo docker build docker-instances/spellinggrammar/ -t spellinggrammar
sudo docker build docker-instances/markdownlint/ -t markdownlint

ASSIGNMENT_FILENAME=assignment.md
ASSIGNMENT_PLAIN_FILENAME=assignment.txt

read -p "Enter markdown URL: " MARKDOWN_URL
# MARKDOWN_URL='https://github.com/cmacdougald/GAME2338/blob/master/gamecritiquetemplate.md'

MARKDOWN_URL=$(echo $MARKDOWN_URL | sed 's,https://github.com/,https://raw.githubusercontent.com/,g')
MARKDOWN_URL=$(echo $MARKDOWN_URL | sed 's,blob/,,g')

echo "Fetching " $MARKDOWN_URL

wget -O $ASSIGNMENT_FILENAME $MARKDOWN_URL

echo "===== Markdown Lint ====="
sudo docker run -v $(pwd):/tmp markdownlint:latest mdl /tmp/$ASSIGNMENT_FILENAME

echo "===== Covert to Text ====="
sudo docker run -v $(pwd):/tmp spellinggrammar:latest pandoc --from markdown --to plain -i /tmp/$ASSIGNMENT_FILENAME -o /tmp/$ASSIGNMENT_PLAIN_FILENAME

echo "===== ASPELL ====="
sudo docker run -v $(pwd):/tmp spellinggrammar:latest cat /tmp/$ASSIGNMENT_PLAIN_FILENAME | aspell -a | grep -v '*'

echo "===== DICTION ====="
sudo docker run -v $(pwd):/tmp spellinggrammar:latest diction -b -s /tmp/$ASSIGNMENT_PLAIN_FILENAME

echo "===== STYLE ====="
sudo docker run -v $(pwd):/tmp spellinggrammar:latest style /tmp/$ASSIGNMENT_PLAIN_FILENAME

# sudo docker system prune -a