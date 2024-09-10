import 'package:flutter/material.dart';
import 'package:yummy/models/restaurant.dart';

class RestaurantItem extends StatefulWidget {
  final Item item;
  const RestaurantItem({super.key, required this.item});

  @override
  State<RestaurantItem> createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
        height: 110,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildListItem()),
            _buildImageStack(colorScheme),
          ],
        ));
  }

  Widget _buildListItem() {
    return ListTile(
      title: Text(widget.item.name),
      subtitle: _buildSubtitle(),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _builDescription(),
        _buildLikesAndPrice(),
      ],
    );
  }

  Widget _builDescription() {
    return Text(
      widget.item.description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildLikesAndPrice() {
    return Row(
      children: [
        Text(
          widget.item.price.toString(),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                isLike = !isLike;
              });
            },
            icon: Icon(
              isLike ? Icons.thumb_up : Icons.thumb_up_outlined,
              color: Colors.amber,
            ))
      ],
    );
  }

  Widget _buildImageStack(ColorScheme colorScheme) {
    return Stack(
      children: [
        _buildImage(),
        _buildIconButton(colorScheme),
      ],
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Image.network(
              widget.item.imageUrl,
              fit: BoxFit.cover,
            ),
          )),
    );
  }

  Widget _buildIconButton(ColorScheme colorScheme) {
    return Positioned(
      bottom: 8.0,
      right: 8.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: const Text(
          'Add',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



// return Padding(
//         padding: const EdgeInsets.all(6),
//         child: Row(
//           // mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(
//                     width: 260,
//                     child: Text(
//                       widget.item.name,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w400,
//                         // color: Color.fromARGB(191, 0, 0, 0)
//                       ),
//                     )),
//                 SizedBox(
//                     width: 260,
//                     child: Text(
//                       widget.item.description,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       widget.item.price.toString(),
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           setState(() {
//                             isLike = !isLike;
//                           });
//                         },
//                         icon: Icon(isLike
//                             ? Icons.thumb_up_alt_outlined
//                             : Icons.thumb_up_alt),
//                         color: Colors.green)
//                   ],
//                 )
//               ],
//             ),
//             SizedBox(
//                 height: 125,
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: AspectRatio(
//                           aspectRatio: 1.0,
//                           child: Image.network(
//                             widget.item.imageUrl,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         right: 0,
//                         bottom: 3,
//                         child: ElevatedButton(
//                           child: const Text(
//                             "Add",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 15),
//                           ),
//                           onPressed: () {},
//                         ))
//                   ],
//                 ))
//           ],
//         ));
//   }
// }
