# Moin API

The Moin API consists of REST endpoints and a WebSockets server.
Every request is JSON or contains JSON data.

Endpoints which are marked with **requires session** (surprisingly) require a session. You can obtain a session with the sign in and register endpoints (described later in this document).
A session is a token string you get from the server. You have to include it as a query-parameter (`session=`).

* Moin
  * [POST /api/moin](#post-moin)
* Users
  * [POST /api/auth]()
  * [GET /api/user/:name](#get-username)
  * [POST /user/gcm](#post-usergcm)

## Moin

### POST /api/moin
**requires session**

Sends a Moin to a user.

#### Body:
```json
{
  "username": "<USER_ID>"
}
```

#### Example:
```bash
export TOKEN=...

curl -n -X POST https://moinapp.herokuapp.com/api/moin?session=$TOKEN \
  -H "Content-Type: application/json" \
  -d '{
  "username": "abcdef"
}'

```
---

## Users

### POST /api/auth

This is the login endpoint. Returns 200 and the user's session or errors.

#### Example:

```bash
curl -n -X POST https://moinapp.herokuapp.com/api/user \
  -H "Content-Type: application/json" \
  -d '{
    "username": "abcdef",
    "email": "a.b@c.d"
    "password": "0123456789",
    "application": "curl"
  }'
```

#### Response:

On success:

**Status Code**: 200

**Body:**
```json
{
 code: "Success",
 session: "TOKEN"
}
```

### GET /api/user/:name

**requires session**

Returns the user with the specified name, or null and 404 if he doesnt exist.

#### Example:

```bash
export TOKEN=...

curl -n -X GET https://moinapp.herokuapp.com/user/heinz?session=$TOKEN \
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
