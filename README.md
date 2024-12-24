# ionic-login-uae-pass

plugin to help you intergate uae pass with your app

## Install

```bash
npm install ionic-login-uae-pass
npx cap sync
```

## API

<docgen-index>

* [`login(...)`](#login)
* [`logout()`](#logout)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### login(...)

```typescript
login(options: UAEPassOptions) => Promise<{ token: string; }>
```

| Param         | Type                                                      |
| ------------- | --------------------------------------------------------- |
| **`options`** | <code><a href="#uaepassoptions">UAEPassOptions</a></code> |

**Returns:** <code>Promise&lt;{ token: string; }&gt;</code>

--------------------


### logout()

```typescript
logout() => Promise<void>
```

--------------------


### Interfaces


#### UAEPassOptions

| Prop              | Type                |
| ----------------- | ------------------- |
| **`redirectUri`** | <code>string</code> |

</docgen-api>
