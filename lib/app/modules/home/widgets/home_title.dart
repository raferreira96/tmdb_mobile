part of '../home_page.dart';

class _HomeTitle extends StatelessWidget {
  const _HomeTitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text('Filmes Mais Bem Avaliados', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
    );
  }
}
