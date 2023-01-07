

class Category {
  final String name;
  final String title;
  final String image;

  Category({
    required this.name,
    required this.title,
    required this.image,
  });
}

final categories = [
  Category(
    name: 'تصميم',
    title: 'Design Category',
    image: 'images/disgin.png',
  ),
  Category(
    name: 'برمجة',
    title: 'Programming Category',
    image: 'images/programming.jpg',
  ),
  Category(
    name: 'اعلانات',
    title: 'Engineering Category',
    image: 'images/referral2.jpg',
  ),
  Category(
    name: 'هندسة',
    title: 'Advertising Category',
    image: 'images/eng.jpg',
  ),
  Category(
    name: 'محاسبة',
    title: 'Accounting Category',
    image: 'images/cant.jpg',
  ),
];
