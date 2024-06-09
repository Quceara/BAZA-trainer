import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSwiper extends StatefulWidget {
  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  final List<Map<String, String>> imagesWithCaptions = [
    {
      'image': 'assets/pictures/privet.jpg',
      'caption':
      'Привет, это приложение для людей которые хотят заниматься спортом и поддерживать свое тело и дух в тонусе!'
    },
    {
      'image': 'assets/pictures/Geraklit2.jpg',
      'caption': 'С помощью него вы можете покорять свои личные вершины и развиваться'
    },
  ];

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();

    return Visibility(
      visible: isVisible,
      child: Scaffold(
        body: Container(
          color: Color.fromARGB(255, 27, 27, 27), // задаем фон
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
                          borderRadius: BorderRadius.circular(16.0), // скругление углов
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6, // 60% от высоты виджета
                            child: OverflowBox(
                              maxHeight: MediaQuery.of(context).size.height * 0.6,
                              child: Image.asset(
                                imagesWithCaptions[index]['image']!,
                                fit: BoxFit.cover, // обрезаем изображение
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0), // добавляем горизонтальные отступы
                          child: Text(
                            imagesWithCaptions[index]['caption']!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // делаем текст белым для контраста
                            ),
                            textAlign: TextAlign.center, // центрируем текст
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
                    onPressed: () {
                      setState(() {
                        isVisible = false; // Установка видимости в false при нажатии на кнопку
                      });
                    },
                    child: Text(
                      'Пропустить',
                      style: TextStyle(
                        color: Colors.white, // делаем текст белым для контраста
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
