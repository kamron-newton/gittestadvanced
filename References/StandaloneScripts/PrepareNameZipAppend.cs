var sql = "UPDATE T_RETAIL_MATCHBACK_QUEUE SET CURRENT_STATUS = 'R' WHERE ANON_TRANSACTION_ID = :transactionId";
var parameters = new DbParameterCollection(); 
parameters.Add(new DbParameter("transactionId", new Guid(input.TransactionId.ToString()), DbType.Guid));
verb.ModifyDatabase(sql, parameters);