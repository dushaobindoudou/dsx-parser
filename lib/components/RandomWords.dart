
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../Component.dart';

// 状态和组件分离是一种好的设计策略
// 声明一个状态类
class RandomWordsState extends State<RandomWords> {
  // TODO Add build() method
  final _suggestions = <WordPair>[]; // 泛型
  final _biggerFont = const TextStyle(fontSize: 18.0, color: Color.fromRGBO(244, 2224, 89, 0.9));
  final Set<WordPair> _saved = new Set<WordPair>(); // 保存的字符集合
  // 构造函数
  RandomWordsState() {

  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: /*1*/ (context, i) {
          print('当前的索引： $i');
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
//        return Text(_suggestions[i].asPascalCase);
        });
  }

  double screenWidth () {
    return MediaQuery.of(context).size.width;
  }

  double screenHeight () {
    return MediaQuery.of(context).size.height;
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // 实例化一个route
      MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
              appBar: AppBar(title: Text("选中的字母")),
              body: ListView.builder(itemBuilder: (context, i) {
                if (divided.length - 1 < i) {
                  return null;
                }
                return Title(null, null);
              })
          );
        },
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return FlatButton(
        onPressed: () {
          if (alreadySaved) {
            this.setState(() {
              _saved.remove(pair);
            });
          } else {
            this.setState(() {
              _saved.add(pair);
            });
          }

        },
        child: ListTile(
          title: Text(
            pair.asPascalCase + '${screenWidth()}' + '${screenHeight()}',
            style: _biggerFont,
          ),
          trailing: new Icon(   // Add the lines from here...
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[      // Add 3 lines from here...
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

// 声明一个有状态的组件
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState () => new RandomWordsState();
}




class Title extends Component {
  String name = null;
  Title(Set props, Set state) : super(props);

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
    return (Text('第一个组件 component ${name}'));
  }
}
