request = require 'request'
async = require 'async'

https = require 'https'
https.globalAgent.maxSockets = 10

http = require 'http'
http.globalAgent.maxSockets = 10

module.exports =
  break: (copt={}, cb) ->
    {url, token, times, parallel} = copt
    opt =
      url: url
      headers:
        "Authorization": token

    hose = (count, done) ->
      console.log "Sending request #{count}..."
      request opt, (err, res, body) ->
        return done err if err?
        console.log ""
        console.log "Body for #{count}:", body
        console.log ""
        done()

    if parallel
      async.forEach [1..times], hose, cb
    else
      async.forEachSeries [1..times], hose, cb