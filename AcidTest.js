/* 
Atomicity - A transaction is one unit, even if it has multiple statements. All or nothing success.
 */

const requests = []
let completed = []
let errors = []
const commit = statement => {}

while (errors.length === 0 && completed.length < requests.length) {
  const result = commit(statement)

  if (result.status === 'error') {
    errors = [result, ...errors]
  } else {
    completed = [result, ...completed]
  }
}

/* 
Consistency - All transactions must follow the rules. EG: foreign key restraits, validations, etc.
 */

/* 
Isolation - The result of concurrent transactions must be the same as the result of sequential transactions. EG: version control in Postgres
 */

/* 
Durability - Committed transactions stay committed.
  */