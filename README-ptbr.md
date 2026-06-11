# recaptcha

Módulo V para validar tokens do Cloudflare Turnstile usando a API Siteverify.

Documentação em inglês: [README.md](README.md)

## Escopo do projeto

Este projeto começou como um pequeno teste para facilitar a integração com o Cloudflare Turnstile. Ele continua intencionalmente como uma camada simples sobre o Siteverify, mesmo tendo acabado sendo usado em um projeto real.

## Instalação

Adicione este módulo a um projeto V e importe-o como `recaptcha`.

```v
import recaptcha
```

## Uso

```v
import recaptcha

fn main() ! {
    response := recaptcha.new(
        token: 'client-response-token'
        secret_key: 'turnstile-secret-key'
    )!

    if !response.is_valid() {
        return error('captcha inválido')
    }

    if !response.is_action('login') {
        return error('ação de captcha inesperada')
    }
}
```

## API

### `ParamsNew`

Entrada da função `new`.

| Campo | Tipo | Descrição |
| --- | --- | --- |
| `token` | `string` | Token gerado pelo widget Turnstile no cliente. |
| `secret_key` | `string` | Chave secreta usada para validar o token na Cloudflare. |
| `expected_action` | `?string` | Campo opcional mantido no contrato público. A implementação atual não envia esse valor para a Cloudflare e não valida a ação automaticamente. Use `RecaptchaResponse.is_action` quando a validação de ação for necessária. |

### `new(param ParamsNew) !RecaptchaResponse`

Envia `token` e `secret_key` para o Siteverify da Cloudflare e retorna a resposta decodificada.

A função retorna erro quando:

- a requisição HTTP falha;
- a Cloudflare retorna um status diferente de 200;
- o corpo da resposta não pode ser decodificado como `RecaptchaResponse`.

### `RecaptchaResponse`

Resposta decodificada retornada pela Cloudflare.

| Campo | Tipo | Descrição |
| --- | --- | --- |
| `success` | `bool` | Indica se a Cloudflare aceitou o token. |
| `challenge_ts` | `string` | Timestamp retornado pela Cloudflare para o desafio. |
| `hostname` | `string` | Hostname associado à validação. |
| `error_codes` | `[]string` | Códigos de erro retornados pela Cloudflare. |
| `action` | `string` | Ação retornada pela Cloudflare, quando configurada no widget. |
| `cdata` | `string` | Dados customizados retornados pela Cloudflare, quando enviados. |

### `is_valid() bool`

Retorna `true` quando `RecaptchaResponse.success` é `true`.

### `is_action(action string) bool`

Retorna `true` quando `RecaptchaResponse.action` é exatamente igual a `action`.

## Observações

- Este módulo não altera a resposta retornada pela Cloudflare.
- A validação de ação é explícita. Chame `is_action` depois de `new` se a aplicação depender de uma ação específica.
- Mantenha a chave secreta no servidor. Não exponha esse valor em código do cliente.
