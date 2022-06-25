import 'package:flutter/material.dart';
import 'package:money_management_app/screens/home/screen_home.dart';

class HomeScreenNavigationBar extends StatelessWidget {
  const HomeScreenNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext context, int updatedIndex, _) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey[300],
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            HomeScreen.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Transactions'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Category'),
          ],
        );
      },
    );
    
  }
}
