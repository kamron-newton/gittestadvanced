var url = verb.GetProgramSettingByParameterName("CONFIDENTIAL_API_URL");
//var url = "https://d3aldv-pvapi.loyalty-lower.peoplecloud.epsilon.com";
//var url = "http://localhost:35101";

var headers = new List<Epsilon.Fusion.ScriptProcessor.Contracts.IHeader> {
new Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer.Header("Authorization", string.Format("OAuth {0}", verb.GetSecurityContext().AccessToken)),
new Epsilon.Fusion.ScriptProcessor.Helpers.VerbContainer.Header("Accept-Language", "en-US")
};

var times = input.Times != null ? Convert.ToInt32(input.Times) : 1;

object body = null; 

input.Result = JToken.FromObject(new List<object>());

for(int i = 0; i < times; ++i){
   input.Result.Add(verb.CallService(url+"/api/v1/infrastructure/scripts/OneSecond/invoke","POST",headers,body,Convert.ToBoolean(input.Async),5));
}