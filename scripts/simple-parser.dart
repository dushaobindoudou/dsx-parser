
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

import 'template.dart' as parseTemplate;

// 遍历整个node树
String travelNode(node, callback) {
  var nodeVal = '';
  if (node is XmlText) {
    if (new RegExp(r'\r|\n').hasMatch(node.toString())) {
      nodeVal = node.toString();
    } else {
      if (new RegExp(r'\{(.+)\}').hasMatch(node.toString())) {
        nodeVal = node.toString().replaceAllMapped(new RegExp(r'\{(.+)\}'), (Match m) {
          return m[1];
        });
      } else {
        nodeVal = '"' + node.toString() + '"';
      }
    }
    callback(node, 0);
    // TODO: 需要对文本进行转译
  } else if (node is XmlElement) {
    // 构建节点
    callback(node, 1);
    var nodeName = node.name.toString();

    var nReg = new RegExp(r'^[A-Z].*');
    var attrStr = node.attributes.map((XmlAttribute xa) {
      var xaStr = xa.toString();
      var xaList = xaStr.split(new RegExp(r'='));
      if (new RegExp(r'"\{(.+)\}"').hasMatch(xaList[1])) {
        xaList[1] = xaList[1].replaceAllMapped(new RegExp(r'"\{(.+)\}"'), (Match m) {
          return m[1];
        });
      }
      return xaList.join(':');
    }).toList().join(',');
    if (nReg.hasMatch(nodeName)) {// 这个表明是组件
      nodeVal = node.name.toString() + '('+ (!attrStr.isEmpty ? attrStr + ',' : '' )+'#)';
    } else {// 表明这个是属性
      nodeVal = node.name.toString() + ':#,';
      nodeVal += !attrStr.isEmpty ? attrStr + ',' : '';
    }
  }
  // 如果有children 继续构建
  if (node.children.length > 0) {
    var childVal = node.children.map((tNode) {
      if (node is XmlText && !node.toString().trim().isEmpty) {
        return '"' + tNode.toString() + '"';
      }
      return travelNode(tNode, callback);
    }).join('');
    nodeVal = nodeVal.replaceAll(new RegExp(r'#'), childVal);
  } else {
    nodeVal = nodeVal.replaceAll(new RegExp(r'#'), '');
  }
  return nodeVal;
}

String addXmlWrapper(String template) {
  return '<Root>' + template + '</Root>';
}

List<String> findImports(String scripts) {
  final reg = new RegExp(r'(^\W*import\W+[^\r|\n]+)', multiLine: true, caseSensitive: false);
  final matchs = reg.allMatches(scripts);
  return matchs.map((Match m) {
    return m.group(0).toString();
  }).toList();
  //  print('当前import匹配的:' + .join('----'));
}

trimImports(String scripts) {
  final reg = new RegExp(r'(^\W*import\W+[^\r|\n]+)', multiLine: true, caseSensitive: false);
  return scripts.replaceAll(reg, '');
}

// 根据传入的模板，转换为Widget对象, 分层遍历
String parserTemplate(String template, viewName) {
//  let root = new Container();
  XmlDocument xmlDom = xml.parse(addXmlWrapper(template));

  var templateEle = xmlDom.rootElement.findElements('template').where((node) {
    if (node is XmlElement) {
      return true;
    }
    return false;
  });
  var scriptEle = xmlDom.rootElement.findElements('script');
  var viewRoot = templateEle.first.children.where((node) {
    if (node is XmlElement) {
      return true;
    }
    return false;
  }).first;

  String scriptStr = scriptEle.first.firstChild.toString();

  var importList = findImports(scriptStr);
  var realScriptStr = trimImports(scriptStr);

  var templateView = parseTemplate.template.replaceAll(new RegExp(r'(\{\{content\}\})'),
      travelNode(viewRoot, (node, type) {
        if (node == null) {
          return '';
        }
        if (type == 1) {// 这是一个节点
//          print('当前节点内容:' + node.toString());
        } else {
//          print('当前文本节点内容:' + node.toString());
        }
      })
  );

  var finalSource = '''
   ${importList.join('\r\n')}
   ${templateView}
   ${realScriptStr}
  ''';

  return finalSource;
}


