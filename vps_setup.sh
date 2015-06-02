background_color() {
	echo ; echo
	echo -e "\033[32m $1"
	tput sgr0
	echo ; echo
}
control_c() {
	echo -en "\n\n*** Exiting ***\n\n"
	exit 1
}
trap control_c SIGINT
sudo adduser deployer sudo
su deployer

echo -en "\n First, install some dependencies ....\n"
sudo apt-get update
sudo apt-get install curl git-core build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libcurl4-openssl-dev libxml2-dev libxslt1-dev python-software-properties

echo -en "\n Now, we will install rbenv into home directory and add some commands to .bashrc \n"
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

echo -en "\n Now, let’s restart the shell and make sure Rbenv is install: \n"
exec $SHELL
type rbenv

echo -en "\n Time for RUBY !! \n"
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo -en "\n  This part may take awhile. Go grab an apple. \n"
rbenv install 2.2.2
rbenv global 2.2.2

echo -en "\n Make sure all is well \n"
ruby -v

echo -en "\n One last step that always trips people up: install Bundler real quick. \n"
gem install bundler
echo -en "\n You will thank me later ;) \n"

echo -en "\n\n*** PostgreSQL ***\n\n"