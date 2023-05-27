Vagrant.configure(2) do |config|
    config.vm.provider :libvirt do |lv|
      lv.driver = 'kvm'
      lv.socket = '/run/libvirt/libvirt-sock'
      lv.cpus = 2
      lv.memory = 4096
  
      # Enable Hyper-V enlightments: https://blog.wikichoon.com/2014/07/enabling-hyper-v-enlightenments-with-kvm.html
      lv.hyperv_feature :name => 'relaxed',  :state => 'on'
      lv.hyperv_feature :name => 'synic',    :state => 'on'
      lv.hyperv_feature :name => 'vapic',    :state => 'on'
      lv.hyperv_feature :name => 'vpindex',  :state => 'on'
    end
    config.vm.network "private_network", ip: "192.168.122.79"
    config.vm.box = "peru/windows-10-enterprise-x64-eval"
    config.vm.box_version = "20230503.01"
    config.vm.guest = :windows
    config.vm.communicator = "winrm"
    config.winrm.max_tries = 300 # default is 20
    config.winrm.retry_delay = 5 #seconds. This is the defaul value and just here for documentation.
  
    config.vm.boot_timeout      = 1000
    config.vm.communicator      = "winrm"
    config.windows.halt_timeout = 15
    config.winrm.password       = "vagrant"
    config.winrm.retry_limit    = 30
    config.winrm.username       = "vagrant"
  
    config.winrm.transport = :plaintext
    config.winrm.basic_auth_only = true
  
    # Port forward for RDP
    config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct:true
    # Port forward for WinRM
    config.vm.network :forwarded_port, guest: 5986, host: 5986, id: "winrm-ssl", auto_correct:true
    config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct:true
  #   end
  end
  