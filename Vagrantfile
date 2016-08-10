# -*- mode: ruby -*-
# vi: set ft=ruby :

# Avoid having to pass --provider=docker
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Tells vagrant to build the image based on the Dockerfile found in
  # the same directory as this Vagrantfile.
  config.vm.define "nodejs" do |v|
    # Tell Vagrant to use Docker
    v.vm.provider "docker" do |d|
      # Build Dockerfile from current directory
      d.build_dir = "."
      # Assign ports 8080 to the container
      d.ports = ['8080:8080']
      # Use the host/proxy Vagrantfile settings to provision
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end
  # Forward port 8080 to host machine
  config.vm.network :forwarded_port, host: 8080, guest: 8080
end
