# Guia de Configuracao — Firedoor Dashboard Online

Este guia configura o dashboard para ficar acessivel via URL publica.
Apos a configuracao, cada atualizacao de dados pelo Cowork publica automaticamente.

---

## O que voce precisa

- Conta no GitHub (gratuita)
- Git instalado no Windows
- Acesso ao PowerShell

---

## Passo 1 — Instalar o Git (se ainda nao tiver)

1. Acesse: https://git-scm.com/download/win
2. Baixe e instale (pode deixar todas as opcoes no padrao)
3. Abra o PowerShell e teste: `git --version`

---

## Passo 2 — Criar conta no GitHub

1. Acesse: https://github.com
2. Clique em "Sign up"
3. Use seu email: henrique.garcia@cabanaburger.com.br
4. Escolha um username (ex: `cabanaburger` ou `henriquecabana`)
5. Confirme o email

---

## Passo 3 — Criar o repositorio no GitHub

1. Apos fazer login, clique no "+" no canto superior direito
2. Selecione "New repository"
3. Preencha:
   - Repository name: `firedoor`
   - Visibility: **Public**
   - NAO marque nenhuma opcao de inicializacao (README, .gitignore, etc.)
4. Clique "Create repository"
5. Anote seu username do GitHub — voce vai precisar no proximo passo

---

## Passo 4 — Configurar autenticacao no Git

O GitHub nao aceita senha comum — usa token.

1. Acesse: https://github.com/settings/tokens/new
2. Em "Note", escreva: `firedoor-deploy`
3. Em "Expiration", selecione `No expiration`
4. Em "Select scopes", marque apenas: `repo`
5. Clique "Generate token"
6. **COPIE o token agora** — ele nao aparece de novo
7. Guarde em lugar seguro (ex: Notas do celular)

---

## Passo 5 — Rodar o setup (uma vez so)

1. Abra o PowerShell
2. Navegue ate esta pasta:
   ```
   cd "C:\Users\HenriqueGarcia\OneDrive - Cabana Burger\Documentos\Vendas 2023 - 2026\firedoor-deploy"
   ```
3. Execute:
   ```
   .\setup.ps1 -GitHubUser SEU_USERNAME -RepoName firedoor
   ```
   (substitua SEU_USERNAME pelo seu usuario do GitHub)

4. Quando o Git pedir senha, coloque o **token** (nao a senha do GitHub)

---

## Passo 6 — Ativar o GitHub Pages

1. Acesse: https://github.com/SEU_USERNAME/firedoor
2. Clique em "Settings" (aba superior)
3. No menu lateral, clique em "Pages"
4. Em "Branch", selecione: `main` | pasta: `/ (root)`
5. Clique "Save"
6. Aguarde 1-2 minutos
7. A URL do dashboard sera: `https://SEU_USERNAME.github.io/firedoor/`

---

## Passo 7 — Publicar atualizacoes

Cada vez que o Cowork atualizar os dados, execute no PowerShell:

```
cd "C:\Users\HenriqueGarcia\OneDrive - Cabana Burger\Documentos\Vendas 2023 - 2026\firedoor-deploy"
.\deploy.ps1
```

O dashboard online atualiza em ~30 segundos.

**Integracao automatica com Cowork:** Posso configurar o Cowork para rodar o deploy.ps1
automaticamente apos cada atualizacao de dados — sem voce precisar fazer nada.

---

## Resumo da estrutura

```
Vendas 2023 - 2026\
   firedoor_dashboard_v2 (1).html   <- arquivo editado pelo Cowork
   firedoor-deploy\
      index.html                    <- copia publicada online (gerada pelo deploy.ps1)
      deploy.ps1                    <- script de publicacao
      setup.ps1                     <- configuracao inicial (uso unico)
      .gitignore                    <- controla o que vai para o GitHub
      GUIA-CONFIGURACAO.md          <- este arquivo
```

---

## Problemas comuns

**"git nao e reconhecido"**: Feche e reabra o PowerShell apos instalar o Git.

**"Authentication failed"**: Certifique-se de usar o token (nao a senha). 
O Windows pode ter salvo a senha antiga — abra "Gerenciador de Credenciais" > 
"Credenciais do Windows" > encontre github.com > edite e coloque o token.

**"Permission denied"**: O script pode estar bloqueado. Execute antes:
`Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
