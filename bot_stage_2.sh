


function field() {
  local line=$(echo "${1}*4-1" | bc)
  echo "${issue}" | sed -n "${line}p"
}


maintainer=$(echo ${GITHUB_REPOSITORY} | cut -d/ -f1)
author=$(gh issue view "${ISSUE_URL}" --json author | cut -d\" -f6)
issue=$(echo -e $(gh issue view "${ISSUE_URL}" --json body | cut -d\" -f4))

[ ! "${maintainer}" = "${author}" ] && {
  echo "Erro: Apenas o mantenedor do repositório pode usar o formulário e por"
  echo "medida de segurança a execução do 'Idris  Bot' está restrita a perfis"
  echo "Pessoai s no  GitHub,  caso queira  usar  uma  organização,  primeiro"
  echo "finalize o processo e então faça um fork na organização"
  
  exit 1
}

workspace_name=$(gh issue view "${ISSUE_URL}" --json title | cut -d\" -f4)
workspace_commercial=$(field 1)
workspace_color_scheme_human=$(field 2)
workspace_module_police_human=$(field 3)
workspace_description=$(echo "${issue}" | grep -m1 -A999 "### E por fim, a descrição" | tail -n +3)

case "${workspace_color_scheme_human}" in
  "Ametista")
    workspace_color_scheme="1"
  ;;
  "Céu azul")
    workspace_color_scheme="2"
  ;;
  "Nuvens")
    workspace_color_scheme="3"
  ;;
  "Argila")
    workspace_color_scheme="4"
  ;;
  "Concreto")
    workspace_color_scheme="5"
  ;;
  "Prata")
    workspace_color_scheme="6"
  ;;
  "Asfalto")
    workspace_color_scheme="7"
  ;;
  "Esmeralda")
    workspace_color_scheme="8"
  ;;
  "Tomate")
    workspace_color_scheme="9"
  ;;
  "Cenoura")
    workspace_color_scheme="10"
  ;;
  "Girassol")
    workspace_color_scheme="11"
  ;;
  "Verde-marinho")
    workspace_color_scheme="12"
  ;;
  *)
    echo "Erro: Resposta inválida para 'Escolha uma cor que combina com o seu espaço de trabalho', preencha usando o formulário"
    exit 1
  ;;
esac

case "${workspace_module_police_human}" in
  "Sim, vai poder mas apenas os que já vem no espaço de trabalho")
    workspace_module_police="clone"
  ;;
  "Sim, qualquer módulo compativel com os módulos adicionados por mim")
    workspace_module_police="clone,import"
  ;;
  "Não, o usuário não vai poder adicionar novos módulos")
    workspace_module_police="disabled"
  ;;
  *)
    echo "Erro: Resposta inválida para 'O usuário vai poder adicionar novos módulos?', preencha usando o formulário"
    exit 1
  ;;
esac

(
  echo "[Workspace Data]"
  echo "display_name=${workspace_name}"
  echo "color_scheme=${workspace_color_scheme}"
  echo "module_police=${workspace_module_police}"
) > data.ini
