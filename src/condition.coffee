operators = [
  'gt'
  'gte'
  'lt'
  'lte'
  'ne'
  'between'
  'notBetween'
  'in'
  'like'
  'notLike'
  'iLike'
  'notILike'
  'overlap'
  'contains'
  'contained'
]

class Condition
  @and: (conditions...) ->
    new Condition({ $and: conditions.map((condition) -> condition.end()) })

  @or: (conditions...) ->
    new Condition({ $or: conditions.map((condition) -> condition.end()) })

  @not: (condition) ->
    new Condition({ $not: [condition.end()] })

  constructor: (@data = {})->
    that = @

  and: (conditions...) => Condition.and(@, conditions...)

  or: (conditions...) => Condition.or(@, conditions...)

  not: () => Condition.not(@)

  end: => @data

factory = (value) -> new Condition(value)
factory.and = Condition.and
factory.or = Condition.or
factory.not = Condition.not
factory.class = Condition
factory.eq = (l, r) -> new Condition({ "#{l}": r })

operators.forEach((operator) ->
  factory[operator] = (l, r) ->
    new Condition({ "#{l}": { "$#{operator}": r } })
)

module.exports = factory