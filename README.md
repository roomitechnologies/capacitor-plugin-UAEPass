# ionic-login-uae-pass

plugin to help you intergate uae pass with your app

## Install

```bash
npm install ionic-login-uae-pass
npx cap sync
```

## API

<docgen-index>

* [`initialize(...)`](#initialize)
* [`login()`](#login)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### initialize(...)

```typescript
initialize(options: { clientId: string; clientSecret: string; environment: 'production' | 'qa' | 'dev'; redirectUri: string; scope: string; state: string; successScheme: string; failScheme: string; signingScope: string; }) => Promise<void>
```

| Param         | Type                                                                                                                                                                                                                     |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`options`** | <code>{ clientId: string; clientSecret: string; environment: 'production' \| 'qa' \| 'dev'; redirectUri: string; scope: string; state: string; successScheme: string; failScheme: string; signingScope: string; }</code> |

--------------------


### login()

```typescript
login() => Promise<{ accessToken: string; userInfo: { uuid: string; firstName: string; lastName: string; email: string; }; }>
```

**Returns:** <code>Promise&lt;{ accessToken: string; userInfo: { uuid: string; firstName: string; lastName: string; email: string; }; }&gt;</code>

--------------------

</docgen-api>
