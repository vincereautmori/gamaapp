# Gama App

Projeto desenvolvido para o TCC do 9º e 10º semestre do curso de Engenharia de Computação, na Unisal.
Grupo: VINCERE AUT MORI <!-- Não faço a ideia do porque desse nome...  -->

### Objetivo do projeto

Nosso projeto tem como objetivo facilitar o registro de multas e ocorrências dos oficiais da Guarda Armada Municipal de Americana (GAMA), com um aplicativo para registrar denuncias por parte do cidadão comum, além de permitir visualizar suas multas. Para o oficial, ele vai poder visualizar em um mapa as ocorrências mais urgentes, além de poder fazer o registro de multas.

## Para o DEV:

#### Para executar o projeto pela primeira vez:

> flutter pub get

> flutter pub run flutter_native_splash:create

> flutter pub run flutter_launcher_icons

#### Comandos ADB:

Para utilizar o modo debug via Wi-Fi, acessar as configurações do seu celular, entrar na tela do Desenvolvedor, procurar "Depuração por Wi-Fi" e ative. Depois, acesse e clique na opção para parear via código, pegue o IP, a Porta e o Código para parear. Depois, use o IP e Porta para conectar com seu aparelho.

> adb pair WIFIIP:PORTA CODIGO

> adb connect WIFIIP:PORTA

Para liberar o acesso a API via `localhost`, use o comando `reverse` passando a porta em que a API está rodando

> adb reverse TCP:PORTAAPI TCP:PORTAAPI

#### Git UTILS

Configuração para facilitar o uso do Git via terminal (usar o comando `git config --global --edit`):

```
[core]
	editor = \"{VSCODE_PATH}\\bin\\code\" --wait
	autocrlf = false
[alias]
	c = !git add --all && git commit -m
	s = !git status -s
	l = !git log --pretty=format:'%C(blue)%h%C(red)%d %C(white)%s - %C(cyan)%cn, %C(green)%cr'
	t = !sh -c 'git tag -a $1 -m $1' -
	amend = !git add --all && git commit --amend --no-edit
	count = !git shortlog -s --grep
```
