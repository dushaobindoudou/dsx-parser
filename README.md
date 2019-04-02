# dsx

根据dsx根式自动生成dart文件，因为dart编写界面异常繁琐也不方便维护添加一种支持xml格式的写法
例如:
```

<template>
    <MaterialApp>
      <title>Welcome eto Flutter dushaobin</title>
      <theme>
        <ThemeData primaryColor="{Colors.red}" />
      </theme>
      <home>
      <Scaffold>
          <body>
            <Center widthFactor="{90}">
              <child>
                <Scaffold>
                  <appBar>
                    <AppBar>
                      <title>
                        <Center widthFactor="{10}">
                          <child>
                            <FlatButton onPressed="{() { print('this is pressed from code'); }}">
                              <child>
                                <Text>Startup Name Generator</Text>
                              </child>
                            </FlatButton>
                          </child>
                        </Center>
                      </title>
                    </AppBar>
                  </appBar>
                  <body>
                    <RandomWords />
                  </body>
                </Scaffold>
              </child>
            </Center>
          </body>
      </Scaffold>
    </home>
</MaterialApp>
</template>

<script>
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../../components/RandomWords.dart';

// import "./deom_script.dart";
import '../../Component.dart';

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


</script>

```

自动生成对应.dart 文件到相同的路径下, 生成后的代码
```

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


```


### emo版本
1. 支持定义事件
2. 只需要引入对应的组件就可以直接使用
3. 因为是直接翻译，所以支持所有的的目前已有的特性

存在的问题：
1. 没有与hot reload 集成 （不难）
2. 没有实现children
3. dart 编译真的很慢


### 如何使用
flutter packages pub run build_runner serve --delete-conflicting-outputs
