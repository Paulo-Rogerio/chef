# 🚀 Devops Chef

- [1) Chef Server](#1-chef-server)
  - [1.1) Vms](#11-vms)
  - [1.3) Install](#13-install)
  - [1.3) Configure](#13-configure)
- [2) Chef WorkStation](#2-chef-workstation)
  - [2.1) Install](#21-install)
  - [2.2) Configure](#22-configure)
- [3) Chef Node](#2-chef-node)
  - [3.1) Install](#31-install)
  - [3.2) Aplicando Receitas](#32-aplicando-receitas)
- [4) Install and Configure PostgreSQL](#4-Install-and-configure-postgresql)

## 1) Chef Server

Nesse tutorial iremos aprender a utilizar essa poderosa ferramenta **Chef** para provisionamento de recursos dentro de uma máquina. O chef é baseado em Ruby, então todos os seus manifestos tem a extensão **.rb**. Nesse tutorial vamos criar todo o cenário usando VirtualBox.

### 1.1) Vms

Como dito no bloco anterior vamos usar VirtualBox para emular o cenário.

| Vm | S.O | Finalidade
| --- | --- | --- |
| Vbox | Ubuntu 20.04 | Chef Server
| Vbox | Ubuntu 20.04 | Chef Workstation
| Vbox | Ubuntu 20.04 | Chef Node - Nginx
| Vbox | Ubuntu 20.04 | Chef Node - PostgreSQL

Cada **Vm** possui 2 inerfaçe de Rede, sendo uma para comunicação interna **( Máquina Host com Máquina Virtual)** e outra interface para saída de internet. O lance é que ao adicionar uma máquina ***( Node para ser gerenciada pela Chef)***, ele usa a interface **NAT** como meio de comunicação entre os Hosts, e isso não é bom para nossos testes pois essa interface não consegue interagir com as outras máquinas.

Para resolver esse problema cada máquina conterá 2 interfaces sendo:
 - **NAT** ( Dedicada para acesso Externo )
 - **Internal** ( Dedicada para acesso Interno)

Outra característica é que a máquina **Chef Server** funcionará como gateway de internet para as demais máquinas, possam ser catalogadas no **Chef-Server** usando o IP da **Rede Interna**.

| Vm | Finalidade | Rede NAT | Rede Internal
| --- | --- | --- | --- |
| Vbox | Chef Server | 10.2.0.15 | 192.168.56.10
| Vbox | Chef WorkStation | 10.2.0.15 | 192.168.56.20
| Vbox | Chef Node - Nginx | 10.2.0.15 | 192.168.56.30
| Vbox | Chef Node - PostgreSQL | 10.2.0.15 | 192.168.56.40

#### Como adequar a rede das Vms?

Criar um script para rotear internet para os Hosts ( Vms ).

```bash
mkdir -p /opt/devops/firewall && \
touch /opt/devops/firewall/firewall.sh && \
chmod +x /opt/devops/firewall/firewall.sh

echo "echo 1 > /proc/sys/net/ipv4/ip_forward" > /opt/devops/firewall/firewall.sh
echo "iptables -A POSTROUTING -t nat -o enp0s3 -j MASQUERADE" >> /opt/devops/firewall/firewall.sh
```

Colocar o script para ser iniciado no boot do Sistema Operacional ( crontab ).

```bash
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
@reboot /opt/devops/firewall/firewall.sh
```

#### E nas estações de trabalho ( Nodes )?

Basta apontar o gateway padrão para a máquina que está funcionando como router.

```bash
vi /etc/netplan/00-installer-config.yaml
```

```yml
network:
  ethernets:
    enp0s3:
      dhcp4: true
      dhcp4-overrides:
       use-routes: false
    enp0s8:
      dhcp4: false
      addresses: [192.168.56.30/24]
      nameservers:
        addresses: [4.2.2.2]
      routes:
      - to: 0.0.0.0/0
        via: 192.168.56.10
  version: 2
```

```bash
route -vn
```

```bash
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.56.10   0.0.0.0         UG    0      0        0 enp0s8
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 enp0s3
192.168.56.0    0.0.0.0         255.255.255.0   U     0      0        0 enp0s8
```

### 1.2) Install
### 1.3) Configure

## 2) Chef WorkStation
### 2.1) Install
### 2.2) Configure

## 3) Chef Node
### 3.1) Install
### 3.2) Aplicando Receitas

## 4) Install and Configure PostgreSQL
