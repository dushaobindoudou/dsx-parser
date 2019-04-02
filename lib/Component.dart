

import 'package:flutter/material.dart';
//library Component;

class Component extends StatefulWidget{

  final Set props;
  ComponetState state = null;

  Component(this.props) {
  }

  setState(callback) {
    state.setState(callback);
  }

  componentDidMouted() {

  }

  void initState() {

  }

  render(contenxt) {
    return Container();
  }

  @override
  State<Component> createState() {
    // TODO: implement createState
    state = ComponetState(this);
    print('当前挂载状态：${state.mounted}');
    return state;
  }
}

class ComponetState extends State<Component> {

  final Component component;

  ComponetState(this.component) {

  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    print('更新了');
  }

  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      component.componentDidMouted();
    }
    component.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return component.render(context);
  }

}


