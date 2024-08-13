import 'package:component_library/src/cirle_image.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

typedef OnUserCardTap = Function(String id);

class UserListCard extends StatelessWidget {
  const UserListCard({
    super.key,
    required this.user,
    required this.onUserCardTap,
  });

  final User user;
  final OnUserCardTap onUserCardTap;

  @override
  Widget build(BuildContext context) {
    final imageRow = Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: CirleImage(photoURL: user.photoURL),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(user.role.name, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ],
    );

    return Card(
      child: InkWell(
        onTap: () => onUserCardTap(user.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageRow,
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: Text(user.email),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(user.phoneNumber),
            ),
          ],
        ),
      ),
    );
  }
}
