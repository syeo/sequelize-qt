# Sequelize Query Tool

### Install
```sh
npm install sequelize-qt --save
```

### Usage

```javascript
QT = require('sequelize-qt');

Query = QT.Query;
Condition = QT.Condition;

// Condition
c = Condition({id: 1}); // `id` = 1
c = Condition.and(c1, c2); // c1 AND c2
c = Condition.or(c1, c2); // c1 OR c2
c = Condition.not(c0); // NOT c0
c = c1.and(c2); // c1 AND c2
c = c1.and(c2).or(c3); // (c1 AND c2) OR c3

/**
 * Supports oper in ['eq', 'gt', 'gte', 'lt', 'lte', 'ne', 'between',
 *                   'notBetween', 'in', 'like', 'notLike', 'iLike',
 *                   'notILike', 'overlap', 'contains', 'contained']
 */
c = Condition[oper](left, right);
c = Condition.eq('id', 1); // Equivalent to Condition({id: 1})

// Query
q = Query.where(c); // ... WHERE c
q = Query.where(c1).and(c2); // ... WHERE c1 AND c2
q = Query.where(c).limit(5); // ... WHERE c LIMIT 5
q = Query.where(c).order("'id' DESC"); // ... WHERE c ORDER BY `...`.`id` DESC
q = Query.where(c).limit(5).offset(10); // ... WHERE c LIMIT 5 OFFSET 10
q = Query.where(c).and(c2); // Equivalent to Query.where(c.and(c2))
q = Query.where(c).or(c2); // Equivalent to Query.where(c.or(c2))

// .end() when .find(...) or .findAll(...)
model.find(q.end());
model.findAll(q.end());
```

### TODO

- Aggregation
- Join?
