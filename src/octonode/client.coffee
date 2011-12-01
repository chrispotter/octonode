#
# client.coffee: A client for github
#
# Copyright © 2011 Pavan Kumar Sunkara. All rights reserved
#

# Requiring modules
request = require 'request'
Me = require './me'
User = require './user'
Repository = require './repository'
Organization = require './organization'

# Initiate class
class Client

  constructor: (@token) ->

  # Get authenticated user instance for client
  me: ->
    new Me this

  # Get user instance for client
  user: (name) ->
    new User name, this

  # Get repository instance for client
  repository: (name) ->
    new Repository name, this

  # Get organization instance for client
  organization: (name) ->
    new Organization name, this

  # Github api URL builder
  query: (uri) ->
    uri = '/' + uri if uri[0] isnt '/'
    uri = "https://api.github.com#{uri}"
    uri+= "?access_token=#{@token}" if @token
    return uri

  # Github api GET request
  get: (path, callback) ->
    request
      uri: @query path
      method: 'GET'
    , (err, res, body) ->
      if err then throw err
      callback res.statusCode, JSON.parse(body)

  # Github api POST request
  post: (path, content={}, callback) ->
    request
      uri: @query path
      method: 'POST'
      body: JSON.stringify content
      headers:
        'Content-Type': 'application/json'
    , (err, res, body) ->
      if err then throw err
      callback res.statusCode, JSON.parse(body)

  # Github api PUT request
  put: (path, content={}, callback) ->
    request
      uri: @query path
      method: 'PUT'
      body: JSON.stringify content
      headers:
        'Content-Type': 'application/json'
    , (err, res, body) ->
      if err then throw err
      callback res.statusCode, JSON.parse(body)

  # Github api DELETE request
  del: (path, content={}, callback) ->
    request
      uri: @query path
      method: 'DELETE'
      body: JSON.stringify content
      headers:
        'Content-Type': 'application/json'
    , (err, res, body) ->
      if err then throw err
      callback res.statusCode, JSON.parse(body)

# Export modules
module.exports = Client
