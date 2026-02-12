---
name: revisao-tech-lead
description: "Revisão sênior completa: qualidade, arquitetura, code smells, segurança, acessibilidade, testes e aderência a padrões"
agent: "5. Tech Lead Validator"
tools:
  - read
  - search
  - web
  - todo
---

# Revisão Técnica — Tech Lead Sênior

Revise o código com o processo completo de **8 dimensões** de análise.

## Processo Obrigatório

1. **Memória**: Consulte `atomic-memory-mcp` para padrões, convenções e decisões anteriores.
2. **Análise em 8 dimensões**:
   - Qualidade de código (legibilidade, SRP, DRY, nomes)
   - Code smells (Long Method, Duplicate Code, Dead Code, God Component, Prop Drilling)
   - Arquitetura e padrões (estrutura, separação de concerns, consistência)
   - TypeScript (zero `any`, interfaces, type safety)
   - Performance (memo, re-renders, lazy loading, bundle size)
   - Segurança (XSS, sanitização, dados sensíveis, CWEs)
   - Acessibilidade (semântica, ARIA, teclado, contraste)
   - Manutenibilidade (extensibilidade, testabilidade, documentação)
3. **Testes** (se presentes): verificar test smells (~50% dos testes gerados por IA têm smells).
4. **Parecer**: Gerar relatório com sumário executivo, pontos fortes, problemas (Obrigatório/Recomendado/Opcional) e veredicto.
5. **Memória**: Registrar novos padrões validados e antipadrões identificados.
6. **Feedback (pós-condição obrigatória)**: Usar `mcp-feedback-enhanced` imediatamente após concluir o parecer técnico.

## Pós-Condição Obrigatória da Etapa Tech Lead

Após emitir o veredicto técnico (APROVADO / APROVADO COM AJUSTES / REPROVADO):

1. Chamar `mcp-feedback-enhanced` obrigatoriamente.
2. Registrar `feedback_status` com um dos valores: `collected | timeout | failed`.
3. Se `timeout` ou `failed`, retornar ao Orchestrator com status parcial e recomendação explícita (`retry-feedback` ou `smart-escalation`).
4. Só considerar a etapa Tech Lead concluída quando o resultado técnico **e** o status da coleta de feedback estiverem presentes.

## Código para Revisão

${input:codigo:Cole o código, indique o arquivo/pasta, ou descreva o que deve ser revisado}

## Contexto da Tarefa

${input:contexto:Qual era o objetivo da implementação? Há constraints específicas?}

## Foco especial (opcional)

${input:foco:Há algo específico para focar? Ex: performance, segurança, refatoração recente}
