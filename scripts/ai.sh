#!/bin/bash

# Requires: curl, jq
# Uses the OpenAI API to translate natural language to shell commands and execute them

# Colores
BOLD='\033[1m'
CYAN='\033[36m'
GREEN='\033[32m'
RED='\033[31m'
YELLOW='\033[33m'
RESET='\033[0m'

if [ -z "$OPENAI_API_KEY" ]; then
  echo -e "${RED}⚠️  You need to export your OpenAI API key:${RESET}"
  echo 'export OPENAI_API_KEY="sk-..."'
  exit 1
fi

prompt="$*"
if [ -z "$prompt" ]; then
  echo -e "${YELLOW}Usá:${RESET} $0 \"describí lo que querés hacer\""
  exit 1
fi

echo -e "${CYAN}📡 Conection to Model...${RESET}"

response=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d @- <<EOF
{
  "model": "gpt-4",
  "messages": [
    {
      "role": "system",
      "content": "Convertí instrucciones en español a un único comando de shell claro, sin explicaciones ni texto adicional. Mostralo limpio y seguro."
    },
    {
      "role": "user",
      "content": "$prompt"
    }
  ],
  "temperature": 0.2
}
EOF
)

# Limpiar respuesta de Markdown (```bash ... ```)
command=$(echo "$response" | jq -r '.choices[0].message.content' | sed 's/^```bash//;s/^```//;s/```$//' | sed '/^$/d')

echo -e "\n${BOLD}${GREEN}💡 Sugested comand:${RESET}"
echo -e "${BOLD}${CYAN}$command${RESET}"

read -p $'\n¿Querés ejecutarlo? (s/n): ' confirm
if [[ "$confirm" =~ ^[sSyY]$ ]]; then
  echo -e "\n${GREEN}🚀 Executing...${RESET}"
  eval "$command"
else
  echo -e "${RED}❌ Cancelado.${RESET}"
fi
