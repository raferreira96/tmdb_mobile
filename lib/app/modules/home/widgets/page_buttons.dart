part of '../home_page.dart';

class PageButtons extends StatelessWidget {
  final HomeController homeController;
  const PageButtons({super.key, required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CustomDefaultButton(
          label: 'Anterior',
          onPressed: () {
            homeController.backPage();
          },
          width: 140),
      Observer(builder: (_) {
        return CustomDefaultButton(
            label: homeController.page.value.toString(),
            onPressed: () {},
            width: 75,
            labelSize: 16);
        //return Text(homeController.page.value.toString());
      }),
      CustomDefaultButton(
          label: 'Próximo',
          onPressed: () {
            homeController.fowardPage();
          },
          width: 140)
    ]);
  }
}
