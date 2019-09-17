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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      final isUpdating = state is FavoriteUpdate && state.isUpdating;
      final favorited =
          state is FavoriteUpdate ? state.value : widget.favorited;
      final textColor = favorited ? Colors.white : theme.primaryColor;
      final backgroundColor = favorited ? theme.primaryColor : Colors.white;

      return InkWell(
        onTap: () {
          favoriteBloc.dispatch(
            UpdateFavoriteEvent(
              slug: widget.slug,
              favorited: !favorited,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(
            top: 5.0,
            bottom: 5.0,
            left: 12.0,
            right: 12.0,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: theme.primaryColor,
            ),
          ),
          child: isUpdating
              ? SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                    backgroundColor: backgroundColor,
                    strokeWidth: 1,
                  ),
                )
              : Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 14,
                      color: textColor,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      widget.favorites.toString(),
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
