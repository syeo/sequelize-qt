module.exports = (sequelize, DataTypes) ->
  return sequelize.define("User", {
    name: {type: DataTypes.STRING},
    role: {type: DataTypes.STRING}
  })
