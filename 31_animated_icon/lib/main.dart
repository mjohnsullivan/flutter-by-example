import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Icon Example',
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final _animatedIconsTuples = {
    'add_event': AnimatedIcons.add_event,
    'arrow_menu': AnimatedIcons.arrow_menu,
    'close_menu': AnimatedIcons.close_menu,
    'ellipsis_search': AnimatedIcons.ellipsis_search,
    'event_add': AnimatedIcons.event_add,
    'home_menu': AnimatedIcons.home_menu,
    'list_view': AnimatedIcons.list_view,
    'menu_arrow': AnimatedIcons.menu_arrow,
    'menu_close': AnimatedIcons.menu_close,
    'menu_home': AnimatedIcons.menu_home,
    'pause_play': AnimatedIcons.pause_play,
    'play_pause': AnimatedIcons.play_pause,
    'search_ellipsis': AnimatedIcons.search_ellipsis,
    'view_list': AnimatedIcons.view_list
  }.entries.toList();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print('Completed');
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          print('Dismissed');
          _controller.forward();
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: _animatedIconsTuples.length,
        itemBuilder: (context, index) {
          return Column(children: [
            Text(
              '${_animatedIconsTuples[index].key}',
            ),
            Expanded(
              child: Center(
                child: AnimatedIcon(
                  icon: _animatedIconsTuples[index].value,
                  progress: _controller,
                ),
              ),
            ),
          ]);
        },
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3));
  }
}
