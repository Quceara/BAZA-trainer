import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSwiper extends StatefulWidget {
  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  final List<Map<String, String>> imagesWithCaptions = [
    {
      'image': 'assets/pictures/Geraklit2.jpg',
      'caption':
      'Привет, это приложение для людей которые хотят заниматься спортом и поддерживать свое тело и дух в тонусе!'
    },
    {
      'image': 'assets/pictures/privet.jpg',
      'caption': 'С помощью него вы можете покорять свои личные вершины и развиваться'
    },
    {
      'image': 'assets/pictures/krutoy1.jpg',
      'caption': 'Ничего не бойся, иди вперед и не оборачивайся!'
    },
    {
      'image': 'assets/pictures/krutoy.jpg',
      'caption': 'Главный враг человека это он сам'
    },
  ];

  bool isVisible = true; // Инициализация переменной видимости
  late SharedPreferences _prefs; // Инициализация SharedPreferences
  late PageController _pageController; // Инициализация контроллера страниц
  bool isLastSlide = false; // Флаг для определения последнего слайда

  @override
  void initState() {
    super.initState();
    _initPrefs(); // Инициализация SharedPreferences
    _pageController = PageController(); // Инициализация контроллера страниц
    _pageController.addListener(_pageListener); // Добавление слушателя для контроллера страниц
  }

  // Функция для инициализации SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();

      //bool hasAppeared = _prefs.getBool('hasAppeared') ?? false;
      //setState(() {
      // isVisible = !hasAppeared;
    //});
  }

  // Функция для установки флага appeared в SharedPreferences
  Future<void> _setAppeared() async {
    await _prefs.setBool('hasAppeared', true);
  }

  // Слушатель для контроллера страниц, определяющий последний слайд
  void _pageListener() {
    if (_pageController.page == imagesWithCaptions.length - 1) {
      setState(() {
        isLastSlide = true;
      });
    } else {
      setState(() {
        isLastSlide = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible, // Установка видимости виджета
      child: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 27, 27, 27), // Задаем фон
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imagesWithCaptions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0), // Скругление углов изображения
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.6, // 60% от высоты виджета
                            child: OverflowBox(
                              maxHeight: MediaQuery.of(context).size.height *
                                  0.6,
                              child: Image.asset(
                                imagesWithCaptions[index]['image']!,
                                fit: BoxFit.cover, // Обрезаем изображение
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0), // Добавляем горизонтальные отступы
                          child: Text(
                            imagesWithCaptions[index]['caption']!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Делаем текст белым для контраста
                            ),
                            textAlign:
                            TextAlign.center, // Центрируем текст
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              SmoothPageIndicator(
                controller: _pageController,
                count: imagesWithCaptions.length,
                effect: WormEffect(
                  dotColor: Colors.white.withOpacity(0.5),
                  activeDotColor: Colors.white,
                  dotHeight: 12,
                  dotWidth: 12,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      await _setAppeared();
                      setState(() {
                        isVisible = false; // Установка видимости в false при нажатии на кнопку
                      });
                    },
                    child: Text(
                      isLastSlide ? 'Я готов!' : 'Пропустить',
                      style: TextStyle(
                        color: Colors.white, // Делаем текст белым для контраста
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
