import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realworld_flutter/blocs/favorite/bloc.dart';

class FavoriteButton extends StatefulWidget {
  final String slug;
  final num favorites;
  final bool favorited;
  FavoriteButton({
    Key key,
    @required this.slug,
    @required this.favorites,
    @required this.favorited,
  }) : super(key: key);
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  void initState() {
    super.initState();
  }

  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      final isUpdating = state is FavoriteUpdating;

      return InkWell(
        onTap: () {
          favoriteBloc.dispatch(
            UpdateFavoriteEvent(
              slug: widget.slug,
              favorited: !widget.favorited,
            ),
          );
        },
        onHighlightChanged: (bool val) {
          setState(() {
            if (val) {
              _pressed = true;
            } else {
              _pressed = false;
            }
          });
        },
        onHover: (_) {
          setState(() => _pressed = true);
        },
        onTapCancel: () {
          setState(() => _pressed = false);
        },
        child: isUpdating
            ? const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              )
            : Container(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  left: 12.0,
                  right: 12.0,
                ),
                decoration: BoxDecoration(
                  color: _pressed || widget.favorited
                      ? theme.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: theme.primaryColor,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.ac_unit,
                      size: 14,
                      color: _pressed || widget.favorited
                          ? Colors.white
                          : theme.primaryColor,
                    ),
                    Text(
                      widget.favorites.toString(),
                      style: TextStyle(
                        color: _pressed || widget.favorited
                            ? Colors.white
                            : theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
