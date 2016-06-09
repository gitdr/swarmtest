domain = 'test.local'

hosts = [
{
  hn: 'swarm1',
  ip: "10.1.0.2"
},
{
  hn: 'swarm2',
  ip: "10.1.0.3"
},
{
  hn: 'swarm3',
  ip: "10.1.0.4"
},
{
  hn: 'swarm4',
  ip: "10.1.0.5"
}
]

Vagrant.configure(2) do |config|
  hosts.each do |host|
    config.vm.define host[:hn] do |vmconfig|
      
      vmconfig.vm.box = 'ubuntu/trusty64'
      vmconfig.vm.hostname = [host[:hn], domain].join(".")

      # config.vm.network "private_network", type: "dhcp",# bridge: "vboxnet0", adapter: 2
      #   virtualbox__intnet: "vboxnet0"
      vmconfig.vm.network "private_network", ip: host[:ip]

      vmconfig.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
      end
    

      vmconfig.vm.provision "shell", path: "#{host[:hn]}.sh"
    end
    
  end
end