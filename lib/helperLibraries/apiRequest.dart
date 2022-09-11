
/*

Future webRequest(context)async{
  if(fetchedBackendData==false){
    print("web request");
    final Uri contactsUrl = Uri.parse('https://www.longtact.com/api_container/broker_contacts_API.php');
    final Uri messageListURL=  Uri.parse('https://www.longtact.com/api_container/broker_allContactMessagesList_API.php');

    Map<String,dynamic> messageArgsJson(){
      final Map<String,dynamic> postData=new Map<String,dynamic>();
      postData["userRequestingID"]="name val"; //---userid
      postData["param1"]="color val";
      return postData;
    }
    var client = http.Client();
    var contactResponse= await client.post(contactsUrl,headers:{"Content-Type":"application/json"}, body:json.encode(contactArgsJson()) );
    var messageListResponse=await client.post(messageListURL,headers:{"Content-Type":"application/json"}, body:json.encode(messageArgsJson()) );

    try {
      //------populate hive contacts
      print('Response status: ${contactResponse.statusCode}');
      var contactsData=jsonDecode(contactResponse.body);
      loadContactsIntoHive(contactsData);
      //-----populate hive chat messages
      print('Response status: ${messageListResponse.statusCode}');
      var messagesData=jsonDecode(messageListResponse.body);
      // print(messagesData.toString());
      loadMessagesIntoHive(messagesData);

    }catch(SocketException){} finally {
      fetchedBackendData=true;
      client.close();
    }
    fetchedBackendData=true;
  }
  //print(await http.read('http://127.0.0.1/appAPI/broker_contacts_API.php'));
}

*/