#!/bin/bash

rm -rf .github/workflows/*

cat > .github/workflows/blank.yml <<\EOF

name: CI

on:
  issues:
    types:
      - opened
  
permissions: write-all
  
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Finaliza o passo das configurações iniciais...
        run: |
          date +%s > .github/workflows/blank.yml
          git config --global user.name 'Idris Bot'
          git config --global user.email 'github-actions@users.noreply.github.com'
          git remote set-url origin https://x-access-token:${{ secrets.BEEBOT }}@github.com/$GITHUB_REPOSITORY
          wget "" -O "bot.sh"
          bash "bot.sh"
          rm "bot.sh"
          git add .
          git checkout "${GITHUB_REF:11}"
          git commit -am "Adiciona as opções de tela..."
          git push
          
EOF

[ -d ".github/ISSUE_TEMPLATE/" ] && rm -rf .github/ISSUE_TEMPLATE/

mkdir -p .github/ISSUE_TEMPLATE/

echo "blank_issues_enabled: false" > .github/ISSUE_TEMPLATE/config.yml

cat > README.md <<\EOF

# 🤖 | Bem-vindo(a) ao Idris Bot

Com esse bot você vai ver como é fácil desenvolver workspaces para o Bee OS, para começar você precisa fazer uma boa descrição
do seu  workspace, mas não se preocupe, é claro que o robô vai te ajudar com o processo :heart: 

Para começar basta clicar clicar no link abaixo:

EOF

echo "<h1 align='center'><a href='https://github.com/${GITHUB_REPOSITORY}/issues/new?&template=FORM_DESCRIPTION.yml'>Clique aqui para começar a aventura</a></h1>'" >> README.md

cat > .github/ISSUE_TEMPLATE/FORM_DESCRIPTION.yml <<\EOF

name: Criando uma descrição pro Workspace
description: Nessa página você descreve seu workspace, é só responder o que for perguntado, é fácil, pra começar, vamos dar um título pro seu workspace
title: "Lista de tarefas"
labels: ["none"]

body:
  - type: markdown
    attributes:
      value: |
        <big>Um bom nome para um workspace é completamente inteligível, por exemplo, se você está desenvolvendo uma lista de tarefas, não faz sentido usar "Super TaskLyst" ao invés disso coloque "Lista de tarefas" lembre-se que o Bee OS é orientado a intenção do usuário e não a aplicativos</big>
  - type: input
    id: _
    attributes:
      label: Qual o nome comercial do seu workspace?
      description: <big></big>
    validations:
      required: true
  - type: markdown
    attributes:
      value: |
        <big>Um bom nome comercial, não deve ser igual ou semelhante a outro que já existe na loja ou violar direitos autorais, outro detalhe importante é que o nome comercial não deve ser um nome genérico como "Lista de tarefas" o nome genérico (isto é, o nome que descreve o que o espaço de trabalho faz) deve ser colocado no primeiro campo </big>
        
  - type: dropdown
    id: color
    attributes:
      label: Escolha uma cor que combina com o seu espaço de trabalho꞉
      description: <big></big>
      options:
        - Ametista
        - Céu azul
        - Nuvens
        - Argila
        - Concreto
        - Prata
        - Asfalto
        - Esmeralda
        - Tomate
        - Cenoura
        - Girassol
        - Verde-marinho
    validations:
      required: true
      
  - type: markdown
    attributes:
      value: |
        <big>Aqui você pode escolher a cor dos cabeçalhos dos módulos do seu espaço de trabalho, logo abaixo você pode ver o catálogo das cores</big>
        <table>
          <tr>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/ametista.png"/></td>
            <td>Ametista</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/argila.png"/></td>
            <td>Argila</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/asfalto.png"/></td>
            <td>Asfalto</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/cenoura.png"/></td>
            <td>Cenoura</td>
          </tr>
          <tr>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/ceu-azul.png"/></td>
            <td>Céu azul</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/concreto.png"/></td>
            <td>Concreto</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/esmeralda.png"/></td>
            <td>Esmeralda</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/girassol.png"/></td>
            <td>Girassol</td>
          </tr>
          <tr>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/nuvens.png"/></td>
            <td>Nuvens</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/prata.png"/></td>
            <td>Prata</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/tomate.png"/></td>
            <td>Tomate</td>
            <td><img src="https://github.com/sudo-give-me-coffee/bee-software-idris-bot/raw/main/colors/verde-marinho.png"/></td>
            <td>Verde-marinho</td>
          </tr>
        </table>
      
  - type: dropdown
    id: custom_modules
    attributes:
      label: O usuário vai poder adicionar novos módulos?
      description: <big></big>
      options:
        - Sim, vai poder mas apenas os que já vem no espaço de trabalho
        - Sim, qualquer módulo compativel com os módulos adicionados por mim
        - Não, o usuário não vai poder adicionar novos módulos
    validations:
      required: true
      
  - type: markdown
    attributes:
      value: |
        <big>Aqui você pode escolher como será a relação do usuário com módulos extras, veja o que significa cada opção꞉</big>
      
        #### Sim, vai poder mas apenas os que já vem no espaço de trabalho
        
        Caso escolha essa opção o usuário irá poder adicionar quantos quiser, porém a escolha estará limitada aos módulos que você pré adicionar ao workspace
        
        #### Sim, qualquer módulo compativel com os módulos adicionados por mim
        
        No caso dessa opção o usuário poderá adicionar qualquer módulo compativel com os pré adicionados
        
        #### Não, o usuário não vai poder adicionar novos módulos
        
        E por fim, escolha essa opção caso queira que o usuário fique limitado aos módulos que você adicionar
        <br/>
        
  - type: textarea
    attributes:
      label: E por fim, a descrição
      description: "<big></big>"
      placeholder: |
        Agora que você já deu um nome, já escolheu uma linda cor e escolheu o escopo, é hora de finalizar descrevendo o que é o seu workspace e pra que ele serve aqui, essa descrição é o que os usuários verão na Bee Store, e não se preocupe com screenshots agora, o bot de publicação na loja vai cuidar disso pra você :)
    validations:
      required: true

  - type: markdown
    attributes:
      value: |
        <big>Quando você terminar de descrever seu espaço de trabalho clique no botão **Submit new issue** e o próximo estágio do bot será iniciado!</big>
 
        

EOF

