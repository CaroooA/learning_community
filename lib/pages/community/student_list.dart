class Student {
  final String name;
  final String tag;
  final String asset;
  final int stock;
  final double price;

  Student({
    this.name,
    this.tag,
    this.asset,
    this.stock,
    this.price,
  });
}

final List<Student> products = [
  Student(
      name: '苏北',
      tag: '1',
      stock: 1,
      price: 71.0),
  Student(
      name: 'Chocolate with berries',
      tag: '2',
      stock: 1,
      price: 71.0),
  Student(
      name: 'Trumoo Candies',
      tag: '3',
      stock: 1,
      price: 71.0),
  Student(
      name: 'Choco-coko',
      tag: '4',
      stock: 1,
      price: 71.0),
  Student(
      name: 'Chocolate tree',
      tag: '5',
      stock: 1,
      price: 71.0),
  Student(
      name: 'Chocolate',
      tag: '6',
      stock: 1,
      price: 71.0),
];