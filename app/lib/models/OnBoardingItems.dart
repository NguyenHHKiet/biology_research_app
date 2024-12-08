class Items {
  final String img;
  final String title;
  final String subTitle;

  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    // Hình ảnh: Một tán rừng nhiệt đới, thể hiện sự đa dạng sinh học.
    img: "assets/biology.json",
    title: "Khám phá đa dạng sinh học",
    subTitle: "Tìm hiểu thới giới sinh vật phong phú,\n từ rừng nhiệt đới.",
  ),
  Items(
    // Hình ảnh: Một vi khuẩn được phóng đại dưới kính hiển vi
    img: "assets/microorganism.json",
    title: "Vi sinh vật \n Thế giới vô hình",
    subTitle:
        "Cùng khám phá những sinh vật nhỏ bé \n nhưng đóng vai trò to lớn.",
  ),
  Items(
    // Hình ảnh: Một chuỗi DNA hoặc cây phân loại sinh học
    img: "assets/evolution.json",
    title: "Phân loại và tiến hóa",
    subTitle: "Khám phá sự liên kết và tiến hóa của các loài sinh vật!!",
  ),
];
