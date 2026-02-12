#!/bin/bash
# Pre-tool guard: protege contra operações perigosas
# e faz log de todas as invocações de ferramentas

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.toolName')
TOOL_ARGS=$(echo "$INPUT" | jq -r '.toolArgs')
TIMESTAMP=$(date -Iseconds)

# Log da invocação
mkdir -p logs
echo "$TIMESTAMP | PRE_TOOL | tool=$TOOL_NAME" >> logs/tools.log

# Bloquear comandos destrutivos perigosos
if [ "$TOOL_NAME" = "bash" ] || [ "$TOOL_NAME" = "execute" ]; then
  COMMAND=$(echo "$TOOL_ARGS" | jq -r '.command // empty')
  
  # Padrões perigosos
  if echo "$COMMAND" | grep -qE "rm -rf /|format [A-Z]:|DROP TABLE|DROP DATABASE|sudo rm|mkfs"; then
    echo '{"permissionDecision":"deny","permissionDecisionReason":"Comando potencialmente destrutivo detectado. Operação bloqueada por segurança."}'
    echo "$TIMESTAMP | BLOCKED | tool=$TOOL_NAME | command=$COMMAND" >> logs/blocked.log
    exit 0
  fi
fi

# Bloquear edição de arquivos de configuração críticos sem aviso
if [ "$TOOL_NAME" = "edit" ] || [ "$TOOL_NAME" = "create" ]; then
  FILE_PATH=$(echo "$TOOL_ARGS" | jq -r '.path // .filePath // empty')
  
  # Arquivos protegidos
  if echo "$FILE_PATH" | grep -qE "\.env$|\.env\.local$|\.env\.production$|package-lock\.json$|yarn\.lock$"; then
    echo '{"permissionDecision":"deny","permissionDecisionReason":"Arquivo sensível detectado ('$FILE_PATH'). Edição manual recomendada."}'
    echo "$TIMESTAMP | BLOCKED | tool=$TOOL_NAME | file=$FILE_PATH" >> logs/blocked.log
    exit 0
  fi
fi

# Permitir por padrão
