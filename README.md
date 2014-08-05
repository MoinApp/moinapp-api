# Moin

The Moin-API speaks JSON. Everywhere. You know why.

Moin consists of 5 basic API calls, that's all you need (for now):

Endpoints which are marked with **requires session** (surprisingly) require a session. You can obtain a session with the sign in and register endpoints (described later in this document).
A session is a Token-String you get from the server. You have to include it as a query-parameter (`session`).
Using this API requires to obtain an API-Key. You can get one from the Server (how depends on the server). You have to add it to every request as a GET-Parameter.

* Moining
  * [POST /moin](#post-moin)
* Users
  * [GET /user/:name](#get-username)
  * [POST /user](#post-user)
  * [POST /user/gcm](#post-usergcm)
  * [POST /user/session](#post-usersession)

## Moining

### POST /moin
**requires session**

Sends a Moin to a user.

#### Body:
```json
{
  "to": "<USER_ID>"
}
```

#### Example:
```bash
export TOKEN=...
export API_KEY=...

curl -n -X POST https://moinapp.herokuapp.com/moin?api_key=$API_KEY&session=$TOKEN \
  -H "Content-Type: application/json" \
  -d '{
  "to": "01234567-89ab-cdef-0123-456789abcdef"
}'

```
---

## Users

### GET /user/:name

**requires session**

Returns the user with the specified name, or null and 404 if he doesnt exist.

#### Example:

```bash
export TOKEN=...
export API_KEY=...

curl -n -i -X GET https://moinapp.herokuapp.com/user/heinz?api_key=$API_KEY&session=$TOKEN \
  -H "Content-Type: application/json"

```

#### Response:

If the user exists:

**Status Code**: 200

**Body:**
```json
{
  "username": "heinz",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "email_hash": "<MD5-Hash of the Email Address>"
}
```

If the user does not exist:

**Status Code**: 404

**Body:**
```json
{}
```

---

### POST /user

Creates a new user.

#### Body:
```json
{
  "username": "<USER_NAME>",
  "email": "<USER_MAIL>",
  "password": "<PASSWORD>"
}

```
#### Example:

```bash
export API_KEY=...

curl -n -X POST https://moinapp.herokuapp.com/user?api_key=$API_KEY \
  -H "Content-Type: application/json" \
  -d '{
  "username": "CrazyUlf",
  "email": "pedacoins@pedab.com"
  "password": "ultraHeinzHax0r"
}'

```

#### Response:
If all went well:

**Status Code**: 200

**Body**:
```json
{
  "code": "Success",
  "session": "ads987sdgfb23498zwebasd83ur9bas8d"
}
```

If the username is taken:

**Status Code**: 400

**Body**:
```json
{
  "code": "UsernameTaken",
  "message": "Username is already taken." 
}
```

If the password is too short:

**Status Code**: 400

**Body**:
```json
{
  "code": "PasswordTooShort",
  "message": "Password is too short." 
}
```

If the username is too short:

**Status Code**: 400

**Body**:
```json
{
  "code": "UsernameTooShort",
  "message": "Username is too short." 
}
```
---
### POST /user/gcm
**requires session**

Adds a new GCM Id to the user.

#### Body:
```json
{
  "gcm_id": "<GCM_ID>"
}
```

#### Example:
```bash
export TOKEN=...
export API_KEY=...

curl -n -X POST https://moinapp.herokuapp.com/user/gcm?api_key=$API_KEY&session=$TOKEN \
  -H "Content-Type: application/json" \
  -d '{
  "gcm_id": "01234567-89ab-cdef-0123-456789abcdef"
}'

```

---
### POST /user/session

Creates a session for a user.

#### Body:
```json
{
  "username": "<USER_NAME>",
  "password": "<PASSWORD>"  
}
```

#### Example:
```bash
export API_KEY=...

curl -n -X POST https://moinapp.herokuapp.com/user/session?api_key=$API_KEY \
  -H "Content-Type: application/json" \
  -d '{
  "username": "CrazyHeinz",
  "password": "UltraUlfHax0r"
}'

```

#### Response:
If all went well:

**Status Code**: 200

**Body**:
```json
{
  "code": "Success",
  "session": "ads987sdgfb23498zwebasd83ur9bas8d"
}
```

If the username or the password is wrong:

**Status Code**: 400

**Body**:
```json
{
  "code": "CredentialsWrong",
  "message": "Username or Password is wrong." 
}
```
