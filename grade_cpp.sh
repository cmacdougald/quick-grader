#/bin/bash
sudo docker build docker-instances/clang/ -t clang

CPP_DIRECTORY=$(pwd)/cpp_dir


mkdir -p $CPP_DIRECTORY

read -p "Enter git folder URL: " GITHUB_URL
# GITHUB_URL='https://github.com/cmacdougald/2020SPRING-ITSE1307/tree/master/crm-chp1-ex1'

GITHUB_URL=$(echo $GITHUB_URL | sed 's,tree/master,trunk,g')

echo "Fetching " $GITHUB_URL

echo "===== Checkout SVN ====="
sudo docker run -v $CPP_DIRECTORY:/tmp clang:latest svn --trust-server-cert checkout $GITHUB_URL /tmp/
echo "===== CPP CHECK ====="
sudo docker run -v $CPP_DIRECTORY:/tmp clang:latest cppcheck --enable=all --check-config /tmp/.
echo "===== CLOC ====="
sudo docker run -v $CPP_DIRECTORY:/tmp clang:latest cloc --by-file /tmp/.
echo "===== Clang-Tidy ====="
# sudo docker run -v $CPP_DIRECTORY:/tmp clang:latest find /tmp/. -type f -name "*.cpp" 
# sudo docker run -v $CPP_DIRECTORY:/tmp clang:latest find /tmp/. -type f -name "*.cpp" | xargs clang-format -i
# sudo docker run -v $CPP_DIRECTORY:/tmp clang:latest clang-format -i /tmp/**/*.cpp

sudo rm -rf $CPP_DIRECTORY
# sudo docker system prune -a