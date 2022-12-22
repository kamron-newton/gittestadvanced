var seconds = input.Seconds != null ? Convert.ToInt32(input.Seconds) : 1;
System.Threading.Thread.Sleep(seconds*1000);
input = "{\"Result\":\"SUCCESS\"}";