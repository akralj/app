const NeDB = require('nedb');

module.exports = function (app) {
  const Model = new NeDB({
    filename: `${app.serverConfig.dbRoot}/users.db`,
    autoload: true
  });

  Model.ensureIndex({ fieldName: 'email', unique: true });

  return Model;
};
