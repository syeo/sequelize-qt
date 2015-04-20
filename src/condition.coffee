class Condition
  @and: (conditions...) ->
    new Condition({ $and: conditions.map((condition) -> condition.end()) })

  @or: (conditions...) ->
    new Condition({ $or: conditions.map((condition) -> condition.end()) })

  @not: (condition) ->
    new Condition({ $not: [condition.end()] })

  constructor: (@data = {})->

  and: (conditions...) => Condition.and(@, conditions...)

  or: (conditions...) => Condition.or(@, conditions...)

  not: () => Condition.not(@)

  end: => @data

factory = (value) -> new Condition(value)
factory.and = Condition.and
factory.or = Condition.or
factory.not = Condition.not
factory.class = Condition

module.exports = factory