# Flutter Web with Docker & Compose

![banner](https://miro.medium.com/v2/resize:fit:828/format:webp/0*ZTY0bvA5gwW0iK-L.png)

Nếu bạn từng thắc mắc liệu có thể triển khai Docker với Flutter Web hay không, hôm nay tôi sẽ mang đến cho bạn một ví dụ thực tế để bạn có thể áp dụng những điều cơ bản đó vào dự án của mình và tạo các bản phát hành được tối ưu hóa cho dự án Flutter của bạn lên máy chủ.

Hãy kích hoạt các phụ thuộc của web flutter bằng lệnh sau:

```bash
flutter packages pub global activate webdev
```

cũng như sau khi bạn có được các phụ thuộc, tôi khuyên bạn nên làm:

![image](https://miro.medium.com/v2/resize:fit:828/format:webp/1*Sn3UIIosNsVQsLR60Lkm6Q.png)

```bash
flutter pub get
webdev serve
```

Để thêm dockerfile, trước tiên bạn phải biết Docker là gì…
![image](https://miro.medium.com/v2/resize:fit:486/format:webp/0*q3fbQy27NjLy1Czb.png)

Nó không gì khác hơn là một nền tảng mã nguồn mở được thiết kế để tạo điều kiện thuận lợi cho việc tạo, triển khai và thực hiện các ứng dụng được chứa trong container. Container là môi trường nhẹ, di động bao gồm mọi thứ cần thiết để chạy ứng dụng, bao gồm thư viện, công cụ và mã, có một số tính năng quan trọng đối với docker khi sử dụng chúng.

## DockerFile

Dockerfile là một tài liệu lệnh được thực thi ở cấp độ dự án, cho phép chúng ta tạo ra một hình ảnh đại diện cho dự án Flutter của mình. Vì vậy, chúng ta phải tạo một Dockerfile và lưu nó trong thư mục gốc của dự án Flutter.

### Build the Docker Image

Mở terminal từ thư mục gốc của ứng dụng và chạy lệnh sau:

```bash
docker build . -t flutter_docker
```

Lệnh này sẽ xây dựng một hình ảnh Docker có tên flutter_docker. Bạn có thể xem hình ảnh này từ ứng dụng Docker Desktop đã cài đặt. Bạn cũng có thể xem hình ảnh bằng lệnh docker images.

### Run the image container

Chạy lệnh sau, hãy nhớ cổng của chúng ta là 9000, đây chỉ là ví dụ, tuy nhiên bạn có thể sử dụng bất kỳ cổng nào bạn muốn:

```bash
docker run -i -p 8080:9000 -td flutter_docker
```

Lệnh này liên kết cổng 9000 được cấu hình trong container với cổng TCP 8080, có thể truy cập từ trình duyệt.

> Điều quan trọng là nếu bạn thay đổi cổng, bạn cũng phải thay đổi nó trong DockerFile và trong server.sh

## Docker Compose

Docker Compose là một công cụ để xác định và quản lý các ứng dụng Docker đa container. Nó cho phép các nhà phát triển xác định toàn bộ cấu hình của một ứng dụng, bao gồm các dịch vụ, mạng, khối lượng và môi trường, trong một tệp YAML có tên là docker-compose.yml.

Tệp này phải nằm trong thư mục gốc của dự án, mặc dù nó không thực sự bắt buộc vì docker-compose là để quản lý nhiều dự án, sau đó hãy tưởng tượng rằng bạn có 5 dự án trong một thư mục và bạn muốn quản lý 5 dự án đó, bạn phải tạo một tệp chứa 5 dự án đó và trong thư mục gốc của thư mục cha, về mặt thực tế, bạn sẽ tạo tệp docker compose, vì bạn phải chỉ ra một số điều, ví dụ trong trường hợp này:

```yml
version: "3"

services:
  frontend:
    build:
      context: ./
    ports:
      - "9000"
```

1. **frontend**: chỉ là tên của dịch vụ.
2. **context**: là đường dẫn PATH của thư mục dự án mà bạn muốn gán cho dịch vụ đó.
3. **ports**: bạn phải luôn xác định cổng, hãy nhớ trong ví dụ này, cổng vẫn là 9000, nếu bạn sử dụng cổng khác thì nó sẽ không hoạt động.

Sau khi tập tin được tạo, chúng ta có thể thực hiện lệnh sau:

```bash
docker-compose up
```

và điều này sẽ nâng cao dịch vụ của docker-compose.yml của chúng tôi.

Hãy nhớ không để các dịch vụ hoạt động, hãy luôn dừng chúng trong trường hợp docker compose, nếu bạn muốn giảm các dịch vụ, bạn phải sử dụng lệnh:

```bash
docker-compose down
```

và điều đó sẽ làm giảm các dịch vụ của docker-compose của bạn.
