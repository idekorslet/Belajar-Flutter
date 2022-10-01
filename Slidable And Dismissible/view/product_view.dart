import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../main.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SlidableAutoCloseBehavior(
          // closeWhenOpened: true,
          child: ListView.builder(
              itemCount: prodData.getProductLength(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // hapus SlidableAutoCloseBehavior yang membungkus ListView.Builder
                // dan pindahkan kesini (bungkus widget slidable) jika ingin membuat multiple menu yang aktif
                return Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    dismissible: DismissiblePane(onDismissed: () {
                      print('on dismissed');
                      prodData.removeProduct(index, setState);
                    }),
                    children: [
                      SlidableAction(
                        autoClose: false,
                        onPressed: (context) {
                          final slidable = Slidable.of(context);
                          slidable?.dismiss(
                            ResizeRequest(const Duration(milliseconds: 300), () {
                              prodData.removeProduct(index, setState);
                            }),
                          );
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.5,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          print('Tombol edit ditekan');
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),

                      SlidableAction(
                        onPressed: (context) {
                          print('Tombol share ditekan');
                        },
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      )
                    ],
                  ),

                  child: buildProductList(index),
                );
              }),
        );
      }
    );
  }

  LayoutBuilder buildProductList(int index) {
    return LayoutBuilder(
      builder: (layoutBuilderContext, constraints) {
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          leading: CircleAvatar(
            child: Text('#${index + 1}'),
          ),
          title: Text(prodData.getProductTitle(index)),
          subtitle: Text(prodData.getProductPrice(index).toString()),
          onTap: () {
            final slidable = Slidable.of(layoutBuilderContext);

            slidable?.openEndActionPane(
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
            );
          },
        );
      }
    );
  }
}
