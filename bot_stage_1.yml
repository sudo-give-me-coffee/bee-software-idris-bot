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

name: Sugerir uma nova categoria para o aplicativo
description: Sugira uma modificação que altera onde o aplicativo será exibido no menu de aplicativos
title: "Modificação onde o aplicativo será exibido"
labels: ["Sugestão tipo 3"]

body:

  - type: input
    id: _
    attributes:
      label: Qual o arquivo .desktop responsável pelo aplicativo?
      description: Esse é o arquivo responsável por iniciar o aplicativo, ele fica localizado em `/usr/share/applications/`
      placeholder: "org.kde.kwrite.desktop"
    validations:
      required: true
  - type: dropdown
    id: category
    attributes:
      label: Onde o aplicativo deve ser exibido?
      description: O local representa as categorias no `Menu de aplicativos` caso escolha `Configurações` o aplicativo será enviado para o `Painel de controle`
      options:
        - Acessórios
        - Configurações
        - Desenvolvimento
        - Escritório
        - Gráficos
        - Internet
        - Multimídia
        - Áudio
        - Sistema
    validations:
      required: true
  - type: dropdown
    id: control
    attributes:
      label:  Qual categoria do painel de controle?
      description: Caso tenha escolhido `Configurações` é necessário escolher uma categoria do `Painel de Controle` caso contrário o aplicativo ficará oculto, caso queira manter na categoria `Configurações` [envie outra issue soicitando a reexibição](https://github.com/Tiger-OperatingSystem/simplifica-xfce/issues/new?assignees=&labels=Sugest%C3%A3o&template=FORM-NAME.yml&title=Reexibir+o+aplicativo&type=1)
      options:
        - Pessoal
        - Hardware
        - Sistema
        - Outros
    validations:
      required: false
  - type: checkboxes
    id: terms
    attributes:
      label: "Termo de bom senso"
      description: Você confirma que não está enviando sugestão de conteúdo racista, sexista, sexual, gore, apologia a violência, preferência política ou conteúdo sensível e/ou proíbido para menores de 18 anos?
      options:
        - label: Sim, não estou
          required: true
EOF

