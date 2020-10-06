import 'package:flutter/material.dart';
import 'package:infinite_scroll/components/character_row.dart';
import 'package:infinite_scroll/components/loader.dart';
import 'package:infinite_scroll/models/Character.dart';
import 'package:infinite_scroll/services/rick_and_morty.dart';

class InfiniteScrollPage extends StatefulWidget {
  @override
  _InfiniteScrollPageState createState() => _InfiniteScrollPageState();
}

class _InfiniteScrollPageState extends State<InfiniteScrollPage> {
  final RickAndMortyService _rickAndMortyService = RickAndMortyService();
  ScrollController _scrollController = ScrollController();

  bool _loading = false;
  int _page = 1;
  List<Character> _characters = List();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    this.loadItems();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      loadItems();
    }
  }

  Future<void> loadItems() async {
    if (!_loading) {
      setState(() => _loading = true);
      List<Character> items = await _rickAndMortyService.getCharacters(_page);
      setState(() {
        _page++;
        _loading = false;
        _characters.addAll(items);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SafeArea(
          bottom: false,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _characters.length + 1,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              if (index >= _characters.length) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Loader(),
                );
              }

              final character = _characters[index];

              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CharacterRow(character: character),
              );
            },
          ),
        ),
      ),
    );
  }
}
