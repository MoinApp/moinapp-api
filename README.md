# Moin

The Moin-API speaks JSON. Everywhere. You know why.

Moin consists of 5 basic API calls, that's all you need (for now):

Endpoints which are marked with **requires session** (surprisingly) require a session. You can obtain a session with the sign in and register endpoints (described later in this document).
A session is a Token-String you get from the server. You have to include it as a query-parameter (`session`).

* [POST /moin](#post-moin)
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

curl -n -X POST https://moinapp.herokuapp.com.com/moin?session=$TOKEN \
  -H "Content-Type: application/json" \
  -d '{
  "to": "01234567-89ab-cdef-0123-456789abcdef"
}'

```
---

## Users

### GET /user/:name

Returns the user with the specified name, or null and 404 if he doesnt exist.

#### Example:

```bash
curl -n -i -X GET https://moinapp.herokuapp.com.com/user/heinz \
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
curl -n -X POST https://moinapp.herokuapp.com.com/user \
  -H "Content-Type: application/json" \
  -d '{
  "username": "CrazyUlf",
  "password": "ultraHeinzHax0r"
}'

```

#### Response:
If all went well:

**Status Code**: 200

**Body**:
```json
{
  "status": 0,
  "session": "ads987sdgfb23498zwebasd83ur9bas8d"
}
```

If the username is taken:

**Status Code**: 400

**Body**:
```json
{
  "status": -1,
  "error": "Username is already taken." 
}
```

If the password is too short:

**Status Code**: 400

**Body**:
```json
{
  "status": -2,
  "error": "Password is too short." 
}
```

If the username is too short:

**Status Code**: 400

**Body**:
```json
{
  "status": -3,
  "error": "Username is too short." 
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

curl -n -X POST https://moinapp.herokuapp.com.com/user/gcm?session=$TOKEN \
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
curl -n -X POST https://moinapp.herokuapp.com.com/user/session \
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
  "status": 0,
  "session": "ads987sdgfb23498zwebasd83ur9bas8d"
}
```

If the username or the password is wrong:

**Status Code**: 400

**Body**:
```json
{
  "status": -1,
  "error": "Username or Password is wrong." 
}
```
