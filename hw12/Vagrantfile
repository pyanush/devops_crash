$script = <<-SCRIPT
set -e
LOG_F="/tmp/sftp-server-setup_"`date "+%F-%T"`".log"
exec &> >(tee "${LOG_F}")
echo "Logging setup to ${LOG_F}"
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "public_network"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2096"
    vb.cpus = "2"
  end
  config.vm.provision "shell" do |s|
    s.path="sftp.sh"
    s.args=["testuser", "0123456789"]
  end

end
