


import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';


class Notifications extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return Scaffold( 
          appBar:AppBar(
             backgroundColor: Colors.white,
            iconTheme: IconThemeData(
            color: Color(0xFF333CC1), 
          ),
            elevation: 2.0,
            centerTitle: true,
            title: Text("Notificationse",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,

            ),
           
            
            ),
           
            

            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: (){},
                child: Text("View",
                 style: TextStyle(
                   color: Color(0xFF333CC1),
                 ),
              ),
                shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
              )
            ],

          ),


          body: Padding(
            padding: const EdgeInsets.all(20.0),
        
            child: Column(
              
             children: <Widget>[ 
                Row(children: <Widget>[
                  Text('invoices blah blah blue tip tap'),

                  SizedBox(width: 20.0),
                
                  Column(
                    children: [
                      Text('N300',
                      style:  TextStyle(
                          fontWeight: FontWeight.bold,
                         color: Color(0xFF333CC1),
                      ),
                      ),
                        SizedBox(height: 8.0),

                      Text('04:50PM',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                        )  
                        ),
                         
                       
                    ],
                   
                  ),
                  SizedBox(width: 40.0),
                  
                  
                   
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: FlatButton(
                   onPressed: (){}, 
                  child: FlatButton(
       color: Color(0xFF333CC1),
        textColor: Colors.white,
        padding: EdgeInsets.all(8.0),
        splashColor:Color(0xFF333CC1),
        onPressed: () {},
  child: Text(
    "View",
    style: TextStyle(fontSize: 20.0),
                   
                  
                   ),
                 ),
         

                 ),
               ),
                  
                   ]  
                    )
               
               ],
                ),
                
          ),
        


          
          );
          
          
          
     
         
      

  
        
    
          
  }
}