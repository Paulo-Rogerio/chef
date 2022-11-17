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

#### Como adequar as Vms?



### 1.2) Install
### 1.3) Configure

## 2) Chef WorkStation
### 2.1) Install
### 2.2) Configure

## 3) Chef Node
### 3.1) Install
### 3.2) Aplicando Receitas

## 4) Install and Configure PostgreSQL
