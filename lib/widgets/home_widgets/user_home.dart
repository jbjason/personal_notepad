import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_notepad/models/my_note.dart';
import 'package:personal_notepad/provider/my_notesP.dart';
import 'package:personal_notepad/widgets/home_widgets/listitem_container.dart';
import 'package:provider/provider.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);
  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<MyNotesP>(context, listen: true);
    return ValueListenableBuilder<Box<MyNote>>(
        valueListenable: Hive.box<MyNote>('myNote').listenable(),
        builder: (context, box, _) {
          final transactions = box.values.toList().cast<MyNote>();
          productsData.initializeItems(transactions);
          return transactions.length == 0
              ? NoNotesAvailable() // If items aren't available
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, right: 15, left: 15),
                        child: ListItemContainer(product: transactions[index]),
                      );
                    },
                    childCount: transactions.length,
                  ),
                );
        });
  }
}

class NoNotesAvailable extends StatelessWidget {
  const NoNotesAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/hello.json', fit: BoxFit.cover, height: 300),
          Text(
            'Opps!!',
            style: GoogleFonts.averiaGruesaLibre(
                fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'Notes aren\'t available right now ..',
            style: GoogleFonts.flamenco(fontSize: 18, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
