---
name: auditoria-qualidade
description: "Auditoria completa de qualidade: code smells, segurança, acessibilidade, performance, testes — somente leitura, sem modificar código"
agent: "1. Workflow Orchestrator"
tools:
  - read
  - search
  - agent
  - todo
  - web
  - thinking-patterns/*
  - shrimp-task-manager/*
  - atomic-memory-mcp/*
  - chrome-devtools-mcp/*
  - minidoracat-mcp-feedback-enhanced/*
---

# Auditoria de Qualidade

Execute uma auditoria completa de qualidade do código/aplicação. **Modo somente leitura** — não modifique código, apenas gere o relatório.

## Dimensões da Auditoria

### 1. Code Smells (Tech Lead Validator)
- Long Method/Component (200+ linhas)
- God Component (múltiplas responsabilidades)
- Duplicate Code (lógica repetida)
- Dead Code (imports/variáveis não usados)
- Prop Drilling (3+ níveis)
- Magic Numbers/Strings
- Inconsistência de padrões

### 2. Segurança (Tech Lead Validator)
- XSS vulnerabilities (dangerouslySetInnerHTML)
- Inputs não sanitizados
- Dados sensíveis expostos no client
- Falta de validação server-side
- CORS misconfiguration
- Dependências com vulnerabilidades conhecidas

### 3. Acessibilidade (Browser Validator)
- HTML semântico
- Labels e alt texts
- Navegação por teclado
- Contraste de cores (WCAG AA)
- ARIA attributes
- Focus management

### 4. Performance (Browser Validator)
- Tempo de carregamento
- Bundle size
- Re-renders desnecessários
- Imagens não otimizadas
- Layout shifts (CLS)
- Lazy loading implementado

### 5. Testes
- Cobertura de testes existentes
- Test smells (assertions fracas, coupling)
- Edge cases não cobertos
- Testes de acessibilidade

## Saída Esperada
Relatório consolidado com:
- Score por dimensão (1-10)
- Top 10 problemas prioritizados por impacto
- Quick wins (fácil de corrigir, alto impacto)
- Plano de melhoria sugerido

## Alvo da Auditoria

${input:alvo:Indique o arquivo, componente, módulo ou pasta para auditar}

## URL para Testes de Runtime (opcional)

${input:url:URL da aplicação para testes de acessibilidade e performance — ou deixe vazio}

## Foco especial (opcional)

${input:foco:Alguma dimensão para focar? Ex: apenas segurança, apenas performance}
