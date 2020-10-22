import 'package:flutter/material.dart';
import "package:english_words/english_words.dart";

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final  _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final  _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,),
        ],
      ),
      body: _buildSuggestions() ,);
  }
  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          final tiles = _saved.map(
            (WordPair pair){
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,  
        ).toList();
        return Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children:divided),
          );
        },
      )
    );
  }
  Widget _buildRow(WordPair pair) {
      final alreadysaved = _saved.contains(pair);
      return ListTile(
        title:Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: Icon(
          alreadysaved ? Icons.favorite : Icons.favorite_border,
          color: alreadysaved ? Colors.red : null,
        ),
        onTap: (){
          setState(() {
            if(alreadysaved){
              _saved.remove(pair);
            } else{
              _saved.add(pair);
            }
          });
        },
      );
    }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i){
        if (i.isOdd){
          return Divider();
        }
        final int index = i ~/2;

        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );

    
    
  }
}