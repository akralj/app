{ authenticate } = require('@feathersjs/authentication').hooks

{ hashPassword, protect } = require('@feathersjs/authentication-local').hooks

module.exports = {
  before: {
    all: [],
    find:   [ authenticate('jwt') ],
    get:    [ authenticate('jwt') ],
    create: [ hashPassword() ],
    update: [ hashPassword(),  authenticate('jwt') ],
    patch:  [ hashPassword(),  authenticate('jwt') ],
    remove: [ authenticate('jwt') ]
  },

  after: {
    # Make sure the password field is never sent to the client. Always must be the last hook
    all: [ protect('password') ],
    find: [],
    get: [],
    create: [],
    update: [],
    patch: [],
    remove: []
  },

  error: {
    all: [],
    find: [],
    get: [],
    create: [],
    update: [],
    patch: [],
    remove: []
  }
}
