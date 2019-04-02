   
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../../components/RandomWords.dart';

// import "./deom_script.dart";
import '../../Component.dart';
   
// 这是自动生成的view代码
Widget __View(component) {
  return MaterialApp(
      title:"Welcome eto Flutter dushaobin",
      theme:
        ThemeData(primaryColor:Colors.red,)
      ,
      home:
      Scaffold(
          body:
            Center(widthFactor:90,
              child:
                Scaffold(
                  appBar:
                    AppBar(
                      title:
                        Center(widthFactor:10,
                          child:
                            FlatButton(onPressed:() { print('this is pressed from code'); },
                              child:
                                Text("Startup Name Generator")
                              ,
                            )
                          ,
                        )
                      ,
                    )
                  ,
                  body:
                    RandomWords()
                  ,
                )
              ,
            )
          ,
      )
    ,
);
}


   





class Demo extends Component {
  String name = null;
  Demo(Set props, Set state) : super(props);

  textPressed() {
    print('text pressed');
  }

  @override
  componentDidMouted() {

    var future = new Future.delayed(const Duration(milliseconds: 3000), () {
      this.setState(() {
        this.name = "dushaobin";
      });
    });

    // TODO: implement componentDidMouted
    return super.componentDidMouted();
  }

  @override
  Widget render(context) {
    return __View(this);
  }
}



  