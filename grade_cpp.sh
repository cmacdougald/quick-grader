#/bin/bash
sudo docker build docker-instances/clang/ -t clang

CPP_DIRECTORY=$(pwd)/cpp_dir

rm -rf $CPP_DIRECTORY
mkdir -p $CPP_DIRECTORY

read -p "Enter git folder URL: " GITHUB_URL
GITHUB_URL='https://github.com/cmacdougald/2020SPRING-ITSE1307/tree/master/crm-chp1-ex1'

GITHUB_URL=$(echo $GITHUB_URL | sed 's,tree/master,trunk,g')

echo "Fetching " $GITHUB_URL

cd $CPP_DIRECTORY

echo "===== Checkout SVN ====="
sudo docker run -v $CCP_DIRECTORY:/tmp clang:latest cd /tmp/; svn checkout $GITHUB_URL


# sudo docker system prune -a