var file = verb.ReadFile(Path.Combine(input.FilePath.ToString(),input.FileName.ToString()));

foreach(var row in file){
	input.Result = row["JOB_ID"].ToString() == input.JobId.ToString()
                && row["RECORD_NBR"].ToString() == input.TransactionId.ToString()
				&& row["FIRST_NM"].ToString() == input.FirstName.ToString()
				&& row["LAST_NM"].ToString() == input.LastName.ToString()
				&& row["STORE_NBR"].ToString() == input.StoreCode.ToString();
	if(input.Result == true) break;
}