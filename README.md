# Moin API

The Moin API consists of REST endpoints and a WebSockets server.
Every request is JSON or contains JSON data.

Endpoints which are marked with **requires session** (surprisingly) require a session. You can obtain a session with the sign in and register endpoints (described later in this document).
A session is a token string you get from the server. You have to include it as a query-parameter (`session`).

The live server is running at http://moinapp.herokuapp.com. It should be running the master branch of http://github.com/MoinApp/moinapp-server/ although this is not guaranteed.

* Moin
  * [Send Moin](#send-moin)
* Users
  * [Authenticate](#authenticate)
  * [Sign Up](#sign-up)
  * [Get user info](#get-user-info)
* Push
  * [Add Android device](#add-android-device)

## Moin

### Send Moin
Sends a Moin to a user.

Route: `/api/moin`
**requires session**

|parameter|description|optional|
|---------|-----------|--------|
|username | The username of the user that should receive the Moin. | no |

---

## Users

### Authenticate
Authenticates the user and acquires a session token.

Route: `/api/auth`

|parameter|description|optional|
|---------|-----------|--------|
|username | The user's username. | no |
|password | The user's password. | no |
|application | The application's identifier. | no |

### Sign Up
Signs up for a new user account and acquires a session token.

Route: `/api/signup`

|parameter|description|optional|
|---------|-----------|--------|
|username | The user's username. | no |
|password | The user's password. | no |
|application | The application's identifier. | no |
|email | The user's email. Will be used for gravatar images. | *yes* |

### Get user info
Returns general information about the specified user.

Route: `/api/user/:username`
**requires session**

**These parameters are part of the url**: *username*.

|parameter|description|optional|
|---------|-----------|--------|
|username | The username of the user whose info should be returned. | no |

## Push

### Add Android device
Add a GoogleCloudMessage identifier that should receive push notifications.

Route: '/api/user/addgcm'
**requires session**

|parameter|description|optional|
|---------|-----------|--------|
|gcmId    | The GCM Id that should be added to the authenticated user. | no |
