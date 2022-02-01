# Chat App

A backend application for handling a chat application <br/>
App is responsible for crating new sub-application each will have a number of chats and each chat can have a number of messages<br/>
This is a Ruby on Rails application. MySQL is used as a DB and Elasticsearch for searching messages 

## Description

The application allows user creating new applications where
each application will have a token (generated by the system) and a name(provided by the user). <br/>
The token is the identifier that devices use to send chats to that application.
Each application can have many chats. a chat have a number. <br/>
Numbering of chats in each application starts from 1 and no two chats in the same application will have the same number. <br/>
The number of the chat is returned in the chat creation request. A chat
contains messages and messages have numbers that start from 1 for each chat. The number of the message is also returned in the message creation request.<br/>
The client identifies the application by its token and the chat by
its number along with the application token. <br/>
Transactions with isolation level serializable are being used for chats and messages creation in order to avoid race conditions. <br/>
There is an endpoint for searching through messages of a specific chat using Elasticsearch<br/> 

## Installation

Clone the Github repository and use docker to start the application <br/>
```
$ git clone https://github.com/Zomaldinho/chat-app.git
$ cd chat-app
$ docker-compose up
```
Wait for some time unitll docker fetches the images, build and run them then make sure this message appears in the terminal window `Listening on http://0.0.0.0:3000` and default rails page is running on `http://localhost:3000`. <br/>


## Usage
This app has 13 endpoints user can use to create applications, chats & messages, you can use them as following :- <br/>
* **Create Application Endpoint** : `POST /application/` used for creating an application
  #### Request Body Params
     name: string, <br/>
  #### Response
    {
      "success": boolean,
      "token": string
    }

* **Get All Applications Endpoint** : `GET /applications/` used for getting all created applications
  #### Response
    {
      "success": boolean,
      "data": [
          {
              "name": string,
              "token": string,
              "chats_count": number,
          }
      ]
    }

* **Get Single Applications Endpoint** : `GET /applications/:token` used to get a single application data given it's token
  #### Response
    {
      "success": boolean,
      "data": [
          {
              "name": string,
              "token": string,
              "chats_count": number,
          }
      ]
    }

* **Edit Application Endpoint** : `PATCH /applications/:token` used to update application name 
  #### Request Body Params
     name: string, <br/>
  #### Response
    {
      "success": boolean,
      "message": "successfully updated"
    }

* **Create Chat Endpoint** : `POST /applications/:token/chat` used for creating a chat inside an application
  #### Request Body Params
     name: string, <br/>
  #### Response
    {
      "success": boolean,
      "chat_number": number
    }

* **Get All Chats Endpoint** : `GET /applications/:token/chats` used for getting all chats of an applications
  #### Response
    {
      "success": boolean,
      "data": [
          {
              "name": string,
              "messages_count": number,
              "chat_number": number,
          }
      ]
    }

* **Get Single Chat Endpoint** : `GET /applications/:token/chats/:chat_number` used to get a single chat data given it's number and application token
  #### Response
    {
      "success": boolean,
      "data": [
          {
              "name": string,
              "messages_count": number,
              "chat_number": number,
          }
      ]
    }

* **Edit Chat Endpoint** : `PATCH /applications/:token/chats/:chat_number` used to update chat name 
  #### Request Body Params
     name: string, <br/>
  #### Response
    {
      "success": boolean,
      "message": "successfully updated"
    }

* **Create Message Endpoint** : `POST /applications/:token/chats/:chat_number/message` used to create a message inside a chat 
  #### Request Body Params
     {
      "sender": string,
      "message": string
    } <br/>
  #### Response
    {
      "success": boolean,
      "message_number": number
    }

* **Get All Messages Endpoint** : `GET /applications/:token/chats/:chat_number/messages` used to get all messages inside a chat
  #### Response
    {
      "success": true,
      "data": [
          {
              "sender": string,
              "message": string,
              "message_number": number,
          }
      ]
    }

* **Get a Message Endpoint** : `GET /applications/:token/chats/:chat_number/messages/:message_number` used to specific message inside a chat
  #### Response
    {
      "success": true,
      "data": {
          "sender": string,
          "message": string,
          "message_number": number,
      }
    }

* **Edit a Message Endpoint** : `PATCH /applications/:token/chats/:chat_number/messages/:message_number` used to update sender or message of a specific chat
  #### Request Body Params
     {
      "sender": string,
      "message": string
    }
  #### Response
    {
      "success": true,
      "message": "successfully updated"
    }
* **Search a chat Endpoint** : `PATCH /applications/:token/chats/:chat_number/messages/search?query=':word'` search for a word inside a chat's messages
  #### Response
    {
      "success": true,
      "data": [
          {
              "sender": string,
              "message": string,
              "message_number": number
          }
      ],
      "count": number
    }

<br/>

### Models
3 models are used to store data
* **Applications model** : in which applications are stored and it has the following properties:<br/> 
    * **name** : name of application <br/>
    * **token** : unique string identifying each application. (this column has an index) <br/>
    * **chats_count** : number of chats inside the application. (gets updated by a cron job every 45 mins) <br/>
    * **createdAt**, **updatedAt** : (timestamp). <br/>
* **Chats model** : in which Chats data are stored and it has the following property:<br/> 
    * **name** : name of chat <br/>
    * **chat_number** : unique number in each application for each chat. (this column has an index) <br/>
    * **messages_count** : number of messages inside the chat. (gets updated by a cron job every 45 mins) <br/>
    * **application_id** : foreign key with refrence to the application id <br/>
* **Messages model** : in which Messages data are stored and it has the following property:<br/> 
  * **sender** : sender of the message <br/>
  * **message** : contents of the message <br/>
  * **message_number** : unique number in each chat for each message. (this column has an index) <br/>
  * **chat_id** : foreign key with refrence to the chat id <br/>

## Things could be imporoved if I had more time
* **Handling Error Messages** : could be handeled in a better way that uses exceptions instead of hard coded ones
* **Cleaner Code** : code could be more cleaner and less repititve especially in routes file
* **Using Redis** : Redis could be used a queue system so that chat and message creation requests can be stored in it and then get handeled one by one and avoid race conditions. I have used transaction with isolation level serializable which should do the job but still redis is a great tool to use.
* **Elsatic Search** : This is my first project to implement ES and if I had more time I could have learnt more about custom analyzers so that it can search also sub-words instead of searching for full words.
* **Tests** : Could have added tests for my code.
