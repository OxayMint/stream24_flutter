import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/accordeon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LetualDemo extends StatefulWidget {
  Widget contentWidget;
  LetualDemo({super.key, required this.contentWidget});

  @override
  State<LetualDemo> createState() => _LetualDemoState();
}

class _LetualDemoState extends State<LetualDemo> {
  List<String> imageUrls = [
    'https://www.letu.ru/common/img/marketplace/cbf5284f-e0fb-4c0d-a7d4-24c3240baa1f.jpg',
    'https://www.letu.ru/common/img/marketplace/96f9fcdb-9526-46a3-94f6-e0f6859a2455.jpg',
    'https://www.letu.ru/common/img/marketplace/96e9a52e-9015-4289-bd3d-db2aab2ea8c2.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.network(
            'https://www.letu.ru/common/img/logo/Logo_Letoile.svg',
            height: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xffE8E8E8),
            ),
            child: Row(
              children: [
                Icon(Icons.keyboard_arrow_left_rounded),
                Text(
                  'Личная гигиена',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: PageView(
                        children:
                            imageUrls.map((e) => Image.network(e)).toList()),
                  ),
                ),
                Text('KITFORT Ирригатор для полости рта',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Text('1 750 ₽',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0xffE0129D))),
                SizedBox(
                  height: 20,
                ),
                Accordeon(
                  label: "Описание",
                  widget: Column(
                    children: [
                      Text(
                          'Стационарный и портативный ирригатор КТ-2917 - это простой и эффективный прибор для чистки полости рта. Тонкая и сильная струя воды, подаваемая под давлением от 0,7 до 8 бар, вымывает остатки еды, налёт из межзубного пространства, массажирует дёсны.\n \nВ комплекте с ирригатором идут 2 классические струйные насадки, например, для двух членов семьи. На насадках есть цветные уплотнительные кольца, чтобы их не путать.\n \nУ прибора имеется 3 режима работы: Норма, Мягко, Пульс. Режим Пульс предназначен для массажа дёсен. Регулятор потока плавно регулирует напор воды от 1 до 5 в выбранном режиме.\n \nЭтого количества достаточно, чтобы полностью обработать все труднодоступные участки во рту. Резервуар съёмный, с крышкой.\n \nКрышка выступает контейнером для хранения насадок и держателя насадок. В комплекте с прибором идёт специальная сумка для удобной транспортировки прибора.\n \nВ собранном виде в резервуар ирригатора целиком помещается корпус, что очень удобно для хранения и транспортировки.\n \nЗаряжать ирригатор с помощью USB-шнура можно от компьютера, через блок питания или через внешний аккумулятор, если вы в дороге. Время полной зарядки составляет около 8 часов.\n \nИрригатор станет идеальным дополнением в комплексном уходе за здоровьем ваших зубов, дёсен и полости рта в целом. Если использовать специальные растворы, то прибор станет отличной профилактикой кариеса, повысит эффективность лечения зубов и дёсен.'),
                      widget.contentWidget,
                    ],
                  ),
                  defaultOpen: true,
                ),
                Divider(
                  height: 5,
                ),
                Accordeon(
                    label: "Харакстеристики",
                    widget: Text('Тип продукта: Ирригатор')),
                Divider(
                  height: 5,
                ),
                Accordeon(
                    label: "Применение",
                    widget: Text(
                        'Использование:\n1. Установите ирригатор на раковине или столике в ванной. Резиновые ножки с присосками обеспечивают прочную фиксацию на раковине или на столике.\n2. Налейте в резервуар воду или специальный раствор, установите нужную насадку в ручку ирригатора.\n3. Поверните поворотный механизм держателя с насадкой, чтобы отрегулировать направление потока воды.\n4. Перед тем как включить ирригатор, наклоните ручку ирригатора под углом 45° и направьте насадку себе в рот. Одной рукой возьмитесь за ручку ирригатора, при этом большой палец должен быть на переключателе "Старт/Стоп", а другой рукой переведите регулятор на корпусе ирригатора вправо до нужного режима.\n5. Включите ирригатор, нажав на кнопку "Старт/Стоп". Наклонитесь над раковиной, а рот слегка приоткройте, установите переключатель на держателе в положение "Старт". Вода из вашего рта должна стекать в раковину. Действуйте в такой последовательности, как указано на рисунке в инструкции: двигайтесь от жевательных зубов к передним, направляйте насадку вдоль контура десны, задерживаясь в межзубных пространствах. Чтобы разбрызгивания было меньше, включайте и выключайте прибор при помощи переключателя на держателе только при нахождении насадки во рту.')),
                Divider(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
