# Moin

The Moin-API speaks JSON. Everywhere. You know why.

Moin consists of 5 basic API calls, that's all you need (for now):

Endpoints which are marked with **requires session** (surprisingly) require a session. You can obtain a session with the sign in and register endpoints (described later in this document).
A session is a Token-String you get from the server. You have to include it as a query-parameter (`session`).

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

curl -n -X POST https://moin.herokuapp.com/moin?session=$TOKEN \
  -H "Content-Type: application/json" \
  -d '{
  "to": "01234567-89ab-cdef-0123-456789abcdef"
}'

```
---

## Users

### HEAD /user/:name

Checks whether a user with the specifed name exists or not (return 200 if he does, 404 if he does not).

#### Example:

```bash
curl -n -i -X HEAD https://moin.herokuapp.com/user/heinz \
  -H "Content-Type: application/json"

```
---

### POST /user

Creates a new user.

#### Body:
```json
{
  "name": "<USER_NAME>",
  "password": "<PASSWORD>"
}

```
#### Example:

```bash
curl -n -X POST https://moin.herokuapp.com/user \
  -H "Content-Type: application/json" \
  -d '{
  "username": "CrazyUlf",
  "password": "ultraHeinzHax0r",
  "gcm_id": "1234"
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
### PUT /user
**requires session**

Updates the GCM Id of the user (they might change).

#### Body:
```json
{
  "gcm_id": "<GCM_ID>"
}
```

#### Example:
```bash
export TOKEN=...

curl -n -X PUT https://moin.herokuapp.com/user?session=$TOKEN \
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
curl -n -X POST https://moin.herokuapp.com/user/session \
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
