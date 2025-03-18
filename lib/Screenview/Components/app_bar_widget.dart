import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Takbirul islam",
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                Text(
                  "Takbirulislam420@gmail.com",
                  style: textTheme.bodySmall?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
