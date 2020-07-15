import 'package:flutter/material.dart';
import 'package:heutagogy_web/views/subject_viewer.dart';

class SectionViewer extends StatefulWidget {
  @override
  _SectionViewerState createState() => _SectionViewerState();
}

class _SectionViewerState extends State<SectionViewer> {
  int _selectedIndex = 0;

  List<String> _sections = [
    'SECTION - A',
    'SECTION - B',
    'SECTION - C',
    'SECTION - D'
  ];

  List<Widget> _sectionBuilder(){
    List<Widget> _sectionItems = [];
    for(int i=0; i<_sections.length; i++){
      _sectionItems.add(
        Container(
          color: _selectedIndex == i ? Colors.grey[200] : Colors.white,
          child: ListTile(
            title: Center(child: Text('${_sections.elementAt(i)}')),
            onTap: (){
              setState(() {
                _selectedIndex = i;
              });
            },
          ),
        )
      );
    }
    return _sectionItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width/5,
            child: Column(
              children: _sectionBuilder()
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width*4/5,
            child: SubjectViewer()
          )
        ],
      ),
    );
  }
}
