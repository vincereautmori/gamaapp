# Gama App

Projeto desenvolvido para o TCC do 9º e 10º semestre do curso de Engenharia de Computação, na Unisal.

Grupo: VINCERE AUT MORI <!-- Não faço a ideia do porque desse nome...  -->

### Objetivo do projeto

Nosso projeto tem como objetivo facilitar o registro de multas e ocorrências dos oficiais da Guarda Armada Municipal de Americana (GAMA), com um aplicativo para registrar denuncias por parte do cidadão comum, além de permitir visualizar suas multas. Para o oficial, ele vai poder visualizar em um mapa as ocorrências mais urgentes, além de poder fazer o registro de multas.

## Desenvolvimento:

#### Requisitos

- Flutter: 3.7.#
- Dart 2.19.#

#### Para executar o projeto pela primeira vez:

```bash
flutter pub get
flutter pub run flutter_native_splash:create
flutter pub run flutter_launcher_icons
```

Crie um arquivo `.env` seguindo o exemplo em `.env-example`.

Conecte um aparelho (emulador ou seu próprio celular). Para conectar via Wi-Fi, siga os comandos ADB abaixo.

Para rodar o aplicativo em modo debug, execute `flutter run` ou aperte F5.

#### Comandos ADB:

Para utilizar o modo debug via Wi-Fi, acesse as configurações do seu celular, entre na tela do Desenvolvedor, procure "Depuração por Wi-Fi" e ative. Depois, clique na opção para parear via código, pegue o IP, a Porta e o Código para parear. Em seguida, use o IP e a Porta para conectar com seu aparelho.

```bash
adb pair WIFIIP:PORTA CODIGO
adb connect WIFIIP:PORTA
```

Para liberar o acesso a API via `localhost`, use o comando `reverse` passando a porta em que a API está rodando

```bash
adb reverse TCP:PORTAAPI TCP:PORTAAPI
```

#### Git UTILS

Para facilitar o uso do Git via terminal, adicione as seguintes configurações ao seu arquivo `.gitconfig`:

```bash
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
