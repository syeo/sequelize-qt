chai = require("chai")
chaiAsPromised = require("chai-as-promised")
Promise = require('bluebird')

db = require('./models')

QT = require('../index')

Query = QT.Query
Condition = QT.Condition

chai.use(chaiAsPromised)
should = chai.should()

Promise.longStackTraces()

loadUser = () ->
  userData = require('./fixtures/user.json')
  db.User.bulkCreate(userData)

resetDB = () ->
  db.sequelize.sync({force: true})
    .then(loadUser)

describe('#id=?', () ->
  it('get by id=1', (done) ->
    resetDB()
      .then(() ->
        db.User.find(Query.where(Condition({id: 1})).end())
      )
      .then((user) -> user.get('id'))
      .should.eventually.equal(1).notify(done)
  )
  it('get by id=100', (done) ->
    resetDB()
      .then(() ->
        db.User.find(Query.where(Condition({id: 100})).end())
      )
      .then((user) -> should.not.exist(user))
      .done(done)
  )
)

describe('#AND', () ->
  it('get by id=1 and role=admin', (done) ->
    resetDB()
      .then(() ->
        db.User.find(
          Query
            .where(
              Condition({id: 1})
                .and(Condition({role: 'admin'}))
            )
            .end()
        )
      )
      .then((user) -> user.get('id'))
      .should.eventually.equal(1).notify(done)
  )
  it('get by id=2 and role=admin', (done) ->
    resetDB()
      .then(() ->
        db.User.find(
          Query
            .where(
              Condition({id: 2})
                .and(Condition({role: 'admin'}))
            )
            .end()
        )
      )
      .then((user) -> user.get('id'))
      .should.eventually.equal(2).notify(done)
  )
  it('get by id=3 and role=admin', (done) ->
    resetDB()
      .then(() ->
        db.User.find(
          Query
            .where(
              Condition({id: 3})
                .and(Condition({role: 'admin'}))
            )
            .end()
        )
      )
      .then((user) -> should.not.exist(user))
      .done(done)
  )
  it('get by id=3 or role=admin', (done) ->
    resetDB()
      .then(() ->
        db.User.find(
          Query
            .where(
              Condition({id: 3})
                .or(Condition({role: 'admin'}))
            )
            .end()
        )
      )
      .then((user) ->
        user.get('id') is 3 or user.get('role') is 'admin'
      )
      .should.eventually.equal(true).notify(done)
  )
)
