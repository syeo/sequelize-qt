Lens = require('data-lens')

Condition = require('./condition')

lenses = {}

['where', 'order', 'limit', 'offset'].forEach((key) ->
  lenses[key] = Lens.key(key)
)

class Query
  @where: (condition) -> new Query({ where: condition })

  @order: (order) -> new Query({ order: order })

  @limit: (limit, offset) -> new Query({ limit: limit, offset: offset })

  constructor: (@data = {}) ->
    @data.where ||= Condition()

  where: (condition) => new Query(lenses.where.set(condition, @data))

  order: (order) => new Query(lenses.order.set(order, @data))

  orderBy: (order) => @order(order)

  limit: (limit) => new Query(lenses.limit.set(limit, @data))

  offset: (offset) => new Query(lenses.offset.set(offset, @data))

  and: (conditions...) => @where(lenses.where.get(@data).and(conditions...))

  or: (conditions...) => @where(lenses.where.get(@data).or(conditions...))

  end: () =>
    ret = {}

    for key, lens of lenses
      ret[key] = lens.get(@data)

    ret.where = ret.where.end()

    return ret

factory = (data) -> new Query(data)
factory.where = Query.where
factory.order = Query.order
factory.limit = Query.limit
factory.class = Query

module.exports = factory
