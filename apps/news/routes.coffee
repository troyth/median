Q = require 'bluebird-q'
_ = require 'underscore'
sd = require("sharify").data
News = require '../../collections/news.coffee'
Contracts = require '../../collections/contracts.coffee'

@index = (req, res, next) ->
  blocks = new News []
  contracts = new Contracts []

  Q.all [
    blocks.fetch cache: true
    contracts.fetch()
  ]
  .then ->
    res.locals.sd.BLOCKS = blocks
    res.locals.sd.ALL_CONTRACTS = contracts
    res.render 'index',
      news: blocks
      contracts: contracts
  .catch next
  .done()
