# Moin API

The Moin API consists of REST endpoints and a WebSockets server.
Every request is JSON encoded and/or contains JSON data.

Endpoints which are marked with "**Requires session.**" (surprisingly) require a session. You can obtain a session with the sign in and register endpoints (described later in this document).
A session is a token string you get from the server. You have to include it as a query-parameter (`session`).

The live server is running at http://moinapp.herokuapp.com. It should be running the master branch of http://github.com/MoinApp/moinapp-server/ although this is not guaranteed.

---

# TOC

* Moin
  * [Send Moin](#send-moin)
* Users
  * [Authenticate](#authenticate)
  * [Sign Up](#sign-up)
  * [Get user info](#get-user-info)
* Push
  * [Add Android device](#add-android-device)
  
---

# REST Documentation

## Moin

### Send Moin
Sends a Moin to a user.

**Requires session.**

#### REST
Route: `/api/moin`

|parameter|description|optional|
|---------|-----------|--------|
|username | The username of the user that should receive the Moin. | no |

#### WebSockets
Event: `moin`

|parameter|description|optional|
|---------|-----------|--------|
| receipientName | The username of the user that should receive the Moin. | no |
| callback | A `function(error, result)` callback. | *yes*

## Users

### Authenticate
Authenticates the user and acquires a session token.

#### REST
Route: `/api/auth`

|parameter|description|optional|
|---------|-----------|--------|
|username | The user's username. | no |
|password | The user's password. | no |
|application | The application's identifier. | no |

#### WebSockets
Event: `auth`

|parameter|description|optional|
|---------|-----------|--------|
|sessionToken | The session token for authentication. **This has to be acquired first via the REST-call.** | no |
|callback | A `function(error, authenticationSuccessful)` callback. | *yes* |

### Sign Up
Signs up for a new user account and acquires a session token.

#### REST
Route: `/api/signup`

|parameter|description|optional|
|---------|-----------|--------|
|username | The user's username. | no |
|password | The user's password. | no |
|application | The application's identifier. | no |
|email | The user's email. Will be used for gravatar images. | *yes* |

### Get user info
Returns general information about the specified user.

**Requires session.**

#### REST
Route: `/api/user/:username`

**These parameters are part of the url**: *username*.

|parameter|description|optional|
|---------|-----------|--------|
|username | The username of the user whose info should be returned. | no |

#### WebSockets
Event: `getUser`

|parameter|description|optional|
|---------|-----------|--------|
|username | The username of the user whose info should be returned. | no |
|callback | A `function(error, user)` callback. | *yes* |

## Push

### Add Android device
Add a GoogleCloudMessage identifier that should receive push notifications.

**Requires session.**

#### REST
Route: '/api/user/addgcm'

|parameter|description|optional|
|---------|-----------|--------|
|gcmId    | The GCM Id that should be added to the authenticated user. | no |
