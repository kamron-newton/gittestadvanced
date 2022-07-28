try	{
		var fileInputLocation = input.FileInputLocation.ToString();
		var fileOutputLocation = input.FileOutputLocation.ToString();
		var tempFolderList = new List<string>();
		
		var locationCheckResults =  ExternalLocationCheck(verb, fileInputLocation);
		var removeFilesAfterTransfer = true;
		
		var localFolderTempId = locationCheckResults.LocalFolderTempId.ToString();
		string fileInputLocationBase = fileInputLocation;
        string fileOuputLocationBase = fileOutputLocation;
		var tempFolderExists = false;
		var tempFolderExistsPostRemove = true;
		
		//Create the file
		string fileName = CreateFile(verb, input);

		//Read the file contents and add to Input
		ReadFile(verb, fileName, ref input);
		
        string includePattern = string.Format("{0}*",fileName.Substring(0,4));
	   
		input.Add("locationCheckResults", locationCheckResults);
		
		if (bool.Parse(locationCheckResults.IsExternal.ToString()))
		{
			fileInputLocationBase = CreateLocalTempFolder(verb, localFolderTempId, fileInputLocation, ref tempFolderList);
			input.Add("InputLocalFolder", fileInputLocationBase);
			tempFolderExists=Directory.Exists(fileInputLocationBase);
			input.Add("tempFolderExistsAfterCreate", tempFolderExists.ToString());
				
			var transferLocalResults = TransferFilesExternalToLocalByPattern(verb, localFolderTempId, fileInputLocation, fileInputLocationBase, includePattern, removeFilesAfterTransfer);
			input.Add("transferLocalResults", transferLocalResults);
					
			var dirInfo = new DirectoryInfo(fileInputLocationBase);

			var lstfiles = (from f in dirInfo.GetFiles(includePattern + "*").Where(x => x.Length > 0)
							orderby f.CreationTime
							select f);
          
			if (lstfiles.Count() > 0)
			{
				var inputArchiveLocation = Path.Combine(fileInputLocationBase, "archived");
				
				var archiveExternalLocation = Path.Combine(fileInputLocation, "archived");
				Directory.CreateDirectory(inputArchiveLocation);
			
				foreach (FileInfo file in lstfiles)
				{
					file.MoveTo(Path.Combine(inputArchiveLocation, "Processed_" + file.Name));
				}
				var transferExternalResults = TransferFilesLocalToExternal(verb, localFolderTempId, inputArchiveLocation, archiveExternalLocation);
				input.Add("transferExternalResults", transferExternalResults);

			}
		
			var removeFolderResults = RemoveLocalTempFolders(verb, localFolderTempId, tempFolderList);
			input.Add("removeFolderResults", removeFolderResults);
			tempFolderExistsPostRemove = Directory.Exists(fileInputLocationBase);
			input.Add("tempFolderExistsPostRemove", tempFolderExistsPostRemove.ToString());
		}

	}
	catch
	{
		throw;
	}
}

public string CreateFile(Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer verb, dynamic input)
{
  var fileName = "";
	if (string.IsNullOrWhiteSpace(input.FileInputLocation.ToString())) 
	{
		input.FileInputLocation = input.FileOutputLocation;
	}
	var outputLocation = input.FileInputLocation;
	var sqlQuery = "SELECT * FROM T_REF_REPORT_TYPE";
	var parameters = new DbParameterCollection();

	var result = verb.QueryDatabase(sqlQuery, parameters);
	
	

	if (input.FileName != null && !string.IsNullOrWhiteSpace(input.FileName.ToString()))
	{
		fileName = input.FileName.ToString();
	}
	else
	{
		fileName = string.Format("{0}_{1}.txt", input.JobName.ToString(), DateTime.Now.Ticks.ToString());
	}
	
	var externalFolder = string.Format(@"{0}", outputLocation);
	verb.WriteFile(fileName, result, externalFolder);
	var fileExists = verb.FileExistsExternal(fileName, externalFolder);

	if(!fileExists)
	{
		throw new ValidationException("FileNotFoundException");
	}
	
	return fileName;
}

public void ReadFile(Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer verb, string fileName, ref dynamic input)
{
	var filePath = string.Format(@"{0}\{1}",input.FileInputLocation, fileName);
	if (input.FileInputLocation.ToString().StartsWith("s3://"))
	{
		filePath=filePath.Replace(@"\","/");
	}
	var fileContents = "";

	var ReadFileContents = verb.ReadFile(filePath);
	foreach (JObject line in ReadFileContents)
	{
		foreach (var value in line.Values())
		{
			fileContents+=value.ToString()+"*** ";
		}
	}
	
	input.Add("FileContents", fileContents);

}

public dynamic ExternalLocationCheck(Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer verb, string location)
{      
	return verb.ExternalLocationCheck(location);
		
}


public string CreateLocalTempFolder(Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer verb, string localFolderTempId, string location, ref List<string> folderList)
{     
	var folderCreated = verb.CreateLocalTempFolder(localFolderTempId, location);
	folderList.Add(folderCreated);
	return folderCreated;
}


public dynamic TransferFilesExternalToLocalByPattern(Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer verb, string localFolderTempId, string sourceFileExternalLocation, string targetFileLocalLocation, string filePattern, bool removeFilesAfterTransfer)
{  
	return verb.TransferFilesExternalToLocalByPattern(localFolderTempId, sourceFileExternalLocation, targetFileLocalLocation, filePattern, removeFilesAfterTransfer);
}

public dynamic TransferFilesLocalToExternal(Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer verb, string localFolderTempId, string sourceFileLocalLocation, string targetFileExternalLocation)
{  
	return verb.TransferFilesLocalToExternal(localFolderTempId, sourceFileLocalLocation, targetFileExternalLocation);
}


public dynamic RemoveLocalTempFolders(Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer verb, string localFolderTempId, List<string> folderList)
{      
	 return verb.RemoveLocalTempFolders(localFolderTempId, folderList);
}

private void DummyFunction()
{
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //End Script
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	