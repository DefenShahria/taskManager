import 'package:flutter/material.dart';
import 'package:module11/screen/loginscreen.dart';
import 'package:module11/screen/updateProfile.dart';
import 'package:module11/utils/signindata.dart';

class userinfo extends StatefulWidget {

  final bool? isupdateScreen ;

  const userinfo({
    super.key,  this.isupdateScreen,
  });

  @override
  State<userinfo> createState() => _userinfoState();
}

class _userinfoState extends State<userinfo> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        if(mounted && widget.isupdateScreen == null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUpdateScreen()));
        }
      },
      trailing: IconButton(icon: Icon(Icons.logout) ,onPressed: () async {
        await Signindata.clearinfo();
        if(mounted){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> loginscrn()), (route) => false);
        }
      },),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.cyan,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(Signindata.userinfo.data?.photo ?? ''),
        onBackgroundImageError: (_, __) {},
        radius: 18,
      ),
      title: Text(
        '${Signindata.userinfo.data!.firstName?? ''} ${Signindata.userinfo.data?.lastName ?? ''}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        Signindata.userinfo.data?.email ?? 'Unknown',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
        ),
      ),
    );
  }
}
