# laravel-nginx

## vagrant
vagrant upした後に、Vagrantfileの
config.vm.synced_folder ".", "/vagrant", owner: "nginx", group: "nginx"
をコメントアウトを外してvagrant reloadすることで、
共有ディレクトリのownerをnginxに変更できる。
