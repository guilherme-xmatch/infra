---
name: validar-implementacao
description: "Validação completa no browser: fluxos, responsividade (1 viewports), acessibilidade, console, rede e performance"
agent: "4. Browser Validator"
tools:
  - read
  - search
  - web
  - todo
  - chrome-devtools-mcp/*
  - shrimp-task-manager/*
---

# Validar Implementação no Browser

Valide a implementação frontend com o processo completo de 7 etapas.

## Processo Obrigatório

1. **Setup**: Acesse a URL base, verifique carregamento, capture screenshot inicial.
2. **Fluxo Principal**: Navegue clicando nos itens (não via URL direta). Teste cenário feliz completo.
3. **Cenários de Erro**: Teste pelo menos 2 cenários (form inválido, estado vazio).
4. **Responsividade**: Valide em **1 viewports** — Desktop (1440x900).
5. **Acessibilidade**: Capture snapshot de acessibilidade. Verifique landmarks, labels, headings, alt texts.
6. **Console/Rede**: Liste erros JS, warnings, requisições com falha, CORS issues.
7. **Performance**: Tempo de carregamento, recursos pesados, layout shifts.

## Relatório
Gere relatório estruturado com:
- Resultados por cenário e viewport
- Problemas classificados por gravidade (Crítica/Média/Baixa)
- Checklist de acessibilidade
- Veredicto: APROVADO / REPROVADO / APROVADO COM RESSALVAS

## URL da Aplicação

${input:url:URL da aplicação para validar (ex: http://localhost:3000)}

## Fluxo a Testar

${input:fluxo:Descreva o fluxo principal a ser validado — passos, funcionalidades esperadas}

## Contexto adicional

${input:contexto:Existe algo específico para verificar? Breakpoints customizados? Fluxos alternativos?}
