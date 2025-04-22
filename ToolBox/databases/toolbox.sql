-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2024 at 06:35 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `toolbox`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `adminid` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `problem_description` text DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `appointment_time` time DEFAULT NULL,
  `service_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `service_id`, `name`, `email_id`, `address`, `phone_number`, `problem_description`, `appointment_date`, `appointment_time`, `service_name`) VALUES
(6, 4, 2, 'Adithyan G', 'adithyan28g@gmail.com', 'BGA-15B-04, Bishop Gate, Tower St', '25448542', 'pest', '2024-08-23', '08:10:00', 'Pest Control Service'),
(8, 4, 1, 'Adithyan Gopakumar', 'adithyan28g@gmail.com', 'BGA-15B-04, Bishop Gate, Tower St', '2544854266', 'full house cleaning', '2024-11-14', '12:02:00', 'Cleaning Services'),
(9, 4, 6, 'Adithyan Gopakumar', 'adithyan28g@gmail.com', 'BGA-15B-04, Bishop Gate, Tower St', '2544854266', 'Repair A/C', '2024-08-22', '07:26:00', 'Air Conditioner Repa'),
(10, 4, 4, 'Adithyan Gopakumar', 'adithyan28g@gmail.com', 'BGA-15B-04, Bishop Gate, Tower St', '2544854266', 'Power issue', '2024-08-22', '23:20:00', 'Electrical Repair an');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`) VALUES
(1, 'Bosch'),
(2, 'DeWalt'),
(3, 'Stanley'),
(4, 'Makita'),
(5, 'Milwaukee'),
(6, 'Milwaukee'),
(7, 'Ryobi'),
(8, 'Hitachi'),
(9, 'Irwin'),
(10, 'Klein Tools');

-- --------------------------------------------------------

--
-- Table structure for table `carousel`
--

CREATE TABLE `carousel` (
  `id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carousel`
--

INSERT INTO `carousel` (`id`, `image_url`, `category_id`, `brand_id`) VALUES
(1, 'https://i0.wp.com/toolguyd.com/blog/wp-content/uploads/2023/11/Home-Depot-Free-Dewalt-Cordless-Power-Tool-Offers-for-Holiday-2023.jpg?resize=600%2C437&ssl=1', 2, 2),
(2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1fnMBNOGVrpIBRsumdFYZ-CNPXNH0gVzMFg&s', 2, NULL),
(3, 'https://www.cbspowertools.com/Files/102358/Img/21/tooloffers-cat-cbs.jpg', 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Hand Tools'),
(2, 'Power Tools'),
(3, 'Safety Equipment'),
(4, 'Gardening Tools'),
(5, 'Electrical Tools'),
(6, 'Plumbing Tools'),
(7, 'Woodworking Tools'),
(8, 'Masonry Tools'),
(9, 'Measuring Tools');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `image_url`, `category_id`, `brand_id`) VALUES
(1, 'https://i.shgcdn.com/6ea1f1a7-d6da-4f5c-8ef2-6d814e5fbaeb/-/format/auto/-/preview/3000x3000/-/quality/lighter/', 2, 5),
(2, 'https://images.prismic.io/tradetools/ZoHyQR5LeNNTwqTQ_makita600x400-8-.png?auto=format,compress', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `professionals`
--

CREATE TABLE `professionals` (
  `professionalid` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Specialization` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `purchase_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `user_id`, `tool_id`, `purchase_date`) VALUES
(3, 4, 5, '2024-08-04'),
(4, 4, 5, '2024-08-04'),
(8, 4, 5, '2024-08-04'),
(10, 4, 5, '2024-08-04'),
(14, 4, 1, '2024-08-05');

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

CREATE TABLE `rentals` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `rental_date` date NOT NULL,
  `return_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rentals`
--

INSERT INTO `rentals` (`id`, `tool_id`, `user_id`, `name`, `email`, `phone_number`, `address`, `rental_date`, `return_date`) VALUES
(3, 2, NULL, 'Adithyan G', 'adithyan28g@gmail.com', '25448542', 'BGA-15B-04, Bishop Gate, Tower St', '2024-08-21', '2024-08-17'),
(4, 2, 4, 'Adithyan G', 'adithyan28g@gmail.com', '25448542', 'BGA-15B-04, Bishop Gate, Tower St', '2024-08-16', '2024-08-25'),
(5, 1, 4, 'Adithyan Gopakumar', 'adithyan28g@gmail.com', '25448542', 'BGA-15B-04, Bishop Gate, Tower St', '2024-08-17', '2024-08-24'),
(6, 1, 4, 'Adithyan Gopakumar', 'adithyan28g@gmail.com', '25448542', 'BGA-15B-04, Bishop Gate, Tower St', '2024-08-22', '2024-08-24'),
(8, 1, 4, 'Adithyan Gopakumar', 'adithyan28g@gmail.com', '2544854266', 'BGA-15B-04, Bishop Gate, Tower St', '2024-08-21', '2024-08-31');

-- --------------------------------------------------------

--
-- Table structure for table `rental_tools`
--

CREATE TABLE `rental_tools` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `rating` decimal(3,2) NOT NULL,
  `description` text NOT NULL,
  `quantity` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rental_tools`
--

INSERT INTO `rental_tools` (`id`, `title`, `discount`, `price`, `image_url`, `category_id`, `brand_id`, `rating`, `description`, `quantity`) VALUES
(1, 'STANLEY Hammer, Curved, Fiberglass, 16-Oz', 3.00, 20.59, 'https://m.media-amazon.com/images/I/511F4+sVF6L._AC_UF894,1000_QL80_.jpg', 1, 3, 4.00, 'This STANLEY® Curved Claw Hammer has a lightweight design with a long handle for improved performance and less user fatigue. The handle has a fibreglass core that adds strength and helps to reduce vibrations. The polished smooth face has a tempered rim to reduce incidences of chipping', 150),
(2, 'DEWALT Atomic 20V MAX* Cordless Drill, 1/2-Inch, Tool Only', 10.00, 129.99, 'https://m.media-amazon.com/images/I/51XzwAey9vL._AC_UF894,1000_QL80_.jpg', 2, 2, 0.00, '', 200),
(3, 'Makita B-36170 Ratchet Screwdriver & Bit Set (47 piece)', 5.00, 20.99, 'https://cdn11.bigcommerce.com/s-320izp4p6a/images/stencil/1280x1280/products/65149/182911/B-36170-1__11184.1698966685.jpg?c=1', 1, 4, 0.00, '', 50),
(4, 'Bosch Safety Goggles', 2.00, 9.99, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-d66S59gRW1Zi92vQWsqWii-yhJOpBvcvRQ&s', 3, 1, 0.00, '', 100),
(5, 'Milwaukee M18F2LM53 18V 530mm Self-Propelled Lawn Mower Bare Unit', 25.00, 699.99, 'https://www.imagedelivery.space/ffx/products/m/milwaukee_m18f2lm53v6.jpg?fm=webp', 4, 5, 0.00, '', 50),
(8, 'Milwaukee M18CHX-0 M18 18V Fuel SDS+ Hammer Drill', 10.00, 299.99, 'https://powertoolmate.2dimg.com/4/m18chx-0-3_df9f9e107d.jpg', 1, 6, 0.00, '', 0),
(9, 'Ryobi ONE+ 18V Li-ion Brushed Cordless Impact driver (1 x 2Ah)', 15.00, 159.99, 'https://kingfisher.scene7.com/is/image/Kingfisher/ryobi-one-18v-li-ion-brushed-cordless-impact-driver-1-x-2ah-r18id2-120s5~4892210184818_01c_bq?$MOB_PREV$&$width=618&$height=618', 4, 7, 0.00, '', 0),
(10, 'HiKOKI (Hitachi) C3610DRJW4Z 36v MULTI VOLT Cordless Brushless 254mm Table Saw ', 20.00, 399.99, 'https://www.bellbristol.co.uk/cdn/shop/products/hitc3610drjw4z_1_4f810d13-99c4-4449-b90e-c1352cb6daca.jpg?v=1710498221', 7, 8, 0.00, '', 0),
(11, 'Irwin Vise-Grip Professional Set of 3 Pliers', 5.00, 24.99, 'https://www.cmwltd.co.uk/images/product/l/VIS10505483-1.png?t=1677596229', 1, 9, 0.00, '', 0),
(12, 'General Purpose 1000V Insulated Tool Kit, 22-piece - 33527', 25.00, 99.99, 'https://data.kleintools.com/sites/all/product_assets/png/klein/33527.png', 6, 10, 0.00, '', 0),
(13, '10-1000V Dual Range Voltage Detector', 10.00, 19.99, 'https://www.milwaukeetool.com/--/web-images/sc/394fa09343a44bcca4d066fae3f34ca8?hash=74984b8a36694fc848b259ca7b624b52&lang=en', 6, 6, 0.00, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) DEFAULT NULL,
  `r_name` varchar(50) NOT NULL,
  `rating` decimal(3,2) NOT NULL DEFAULT 0.00,
  `review_text` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `tool_id`, `r_name`, `rating`, `review_text`) VALUES
(5, 1, 'adi', 2.00, 'good'),
(7, 1, 'rohan', 4.00, 'great product'),
(8, 1, 'rohan', 4.00, 'great  product');

-- --------------------------------------------------------

--
-- Table structure for table `r_reviews`
--

CREATE TABLE `r_reviews` (
  `id` int(11) NOT NULL,
  `rtool_id` int(11) DEFAULT NULL,
  `r_name` varchar(255) DEFAULT NULL,
  `review_text` varchar(255) DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `r_reviews`
--

INSERT INTO `r_reviews` (`id`, `rtool_id`, `r_name`, `review_text`, `rating`) VALUES
(1, 1, 'adi', 'Good', 4.00),
(2, 1, 'rohan', 'great product', 5.00);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `icon`) VALUES
(1, 'Cleaning Services', 'Professional cleaning services for your home or office.', 'bi bi-bucket-fill'),
(2, 'Pest Control Services', 'Effective pest control solutions to keep your space pest-free.', 'bi bi-bug-fill'),
(3, 'Plumbing Repair and Services', 'Comprehensive plumbing repair and maintenance services.', 'bi bi-tools'),
(4, 'Electrical Repair and Services', 'Expert electrical repair and maintenance services.', 'bi bi-lightning-charge-fill'),
(5, 'Carpentry Repair and Services', 'Quality carpentry repair and custom furniture services.', 'bi bi-hammer'),
(6, 'Air Conditioner Repair and Services', 'Reliable air conditioner repair and maintenance services.', 'bi bi-snow'),
(7, 'Refrigerator Repair and Services', 'Professional refrigerator repair and maintenance services.', 'bi bi-snow2'),
(8, 'Washing Machine Repair and Services', 'Expert washing machine repair and maintenance services.', 'bi bi-bucket'),
(9, 'Microwave Repair and Services', 'Reliable microwave repair and maintenance services.', 'bi bi-dash-square'),
(10, 'Water Purifier Repair and Services', 'Quality water purifier repair and maintenance services.', 'bi bi-droplet'),
(11, 'Geyser Repair and Services', 'Expert geyser repair and maintenance services.', 'bi bi-thermometer'),
(12, 'Painting Services', 'Professional painting services for your home or office.', 'bi bi-brush'),
(13, 'Disinfection Services', 'Thorough disinfection services to keep your space hygienic.', 'bi bi-shield-fill-check'),
(14, 'Home Repairs', 'General home repair services to fix any issue around your house.', 'bi bi-tools');

-- --------------------------------------------------------

--
-- Table structure for table `tools`
--

CREATE TABLE `tools` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT 0.00,
  `description` text DEFAULT NULL,
  `quantity` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tools`
--

INSERT INTO `tools` (`id`, `title`, `discount`, `price`, `image_url`, `category_id`, `brand_id`, `rating`, `description`, `quantity`) VALUES
(1, 'STANLEY Hammer, Curved, Fiberglass, 16-Oz', 3.00, 20.59, 'https://m.media-amazon.com/images/I/511F4+sVF6L._AC_UF894,1000_QL80_.jpg', 1, 3, 0.00, 'This STANLEY® Curved Claw Hammer has a lightweight design with a long handle for improved performance and less user fatigue. The handle has a fibreglass core that adds strength and helps to reduce vibrations. The polished smooth face has a tempered rim to reduce incidences of chipping', 49),
(2, 'DEWALT Atomic 20V MAX* Cordless Drill, 1/2-Inch, Tool Only', 10.00, 129.99, 'https://m.media-amazon.com/images/I/51XzwAey9vL._AC_UF894,1000_QL80_.jpg', 2, 2, 0.00, NULL, 50),
(3, 'Makita B-36170 Ratchet Screwdriver & Bit Set (47 piece)', 5.00, 20.99, 'https://cdn11.bigcommerce.com/s-320izp4p6a/images/stencil/1280x1280/products/65149/182911/B-36170-1__11184.1698966685.jpg?c=1', 1, 4, 0.00, NULL, 49),
(4, 'Bosch Safety Goggles', 2.00, 9.99, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-d66S59gRW1Zi92vQWsqWii-yhJOpBvcvRQ&s', 3, 1, 0.00, NULL, 49),
(5, ' Milwaukee M18F2LM53 18V 530mm Self-Propelled Lawn Mower Bare Unit ', 25.00, 699.99, 'https://www.imagedelivery.space/ffx/products/m/milwaukee_m18f2lm53v6.jpg?fm=webp', 4, 5, 0.00, NULL, 39),
(6, 'Milwaukee M18CHX-0 M18 18V Fuel SDS+ Hammer Drill', 10.00, 299.99, 'https://powertoolmate.2dimg.com/4/m18chx-0-3_df9f9e107d.jpg', 1, 6, 0.00, NULL, 0),
(7, 'Ryobi ONE+ 18V Li-ion Brushed Cordless Impact driver (1 x 2Ah)', 15.00, 159.99, 'https://kingfisher.scene7.com/is/image/Kingfisher/ryobi-one-18v-li-ion-brushed-cordless-impact-driver-1-x-2ah-r18id2-120s5~4892210184818_01c_bq?$MOB_PREV$&$width=618&$height=618', 4, 7, 0.00, NULL, 0),
(8, 'HiKOKI (Hitachi) C3610DRJW4Z 36v MULTI VOLT Cordless Brushless 254mm Table Saw ', 20.00, 399.99, 'https://www.bellbristol.co.uk/cdn/shop/products/hitc3610drjw4z_1_4f810d13-99c4-4449-b90e-c1352cb6daca.jpg?v=1710498221', 7, 8, 0.00, NULL, 0),
(9, 'Irwin Vise-Grip Professional Set of 3 Pliers', 5.00, 24.99, 'https://www.cmwltd.co.uk/images/product/l/VIS10505483-1.png?t=1677596229', 1, 9, 0.00, NULL, 0),
(10, 'General Purpose 1000V Insulated Tool Kit, 22-piece - 33527', 25.00, 99.99, 'https://data.kleintools.com/sites/all/product_assets/png/klein/33527.png', 6, 10, 0.00, NULL, 0),
(11, '10-1000V Dual Range Voltage Detector', 10.00, 19.99, 'https://www.milwaukeetool.com/--/web-images/sc/394fa09343a44bcca4d066fae3f34ca8?hash=74984b8a36694fc848b259ca7b624b52&lang=en', 6, 6, 0.00, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email_id` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email_id`, `dob`, `address`, `phone_number`, `password`) VALUES
(4, 'Adithyan G', 'adithyan28g@gmail.com', '1999-01-27', 'BGA-15B-04, Bishop Gate, Tower St', '2544854266', '$2b$12$JguTkeKOnFDtio.u.judkeqMClWJdtMjDqfdtpXoijvgFCs5ZPAz6');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `vendorid` int(11) NOT NULL,
  `CompanyName` varchar(100) NOT NULL,
  `ContactPerson` varchar(50) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`adminid`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carousel`
--
ALTER TABLE `carousel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `professionals`
--
ALTER TABLE `professionals`
  ADD PRIMARY KEY (`professionalid`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tool_id` (`tool_id`);

--
-- Indexes for table `rentals`
--
ALTER TABLE `rentals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tool_id` (`tool_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `rental_tools`
--
ALTER TABLE `rental_tools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tool_id` (`tool_id`);

--
-- Indexes for table `r_reviews`
--
ALTER TABLE `r_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rtool_id` (`rtool_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tools`
--
ALTER TABLE `tools`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email_id` (`email_id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`vendorid`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `adminid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `carousel`
--
ALTER TABLE `carousel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `professionals`
--
ALTER TABLE `professionals`
  MODIFY `professionalid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `rentals`
--
ALTER TABLE `rentals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `rental_tools`
--
ALTER TABLE `rental_tools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `r_reviews`
--
ALTER TABLE `r_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `tools`
--
ALTER TABLE `tools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `vendorid` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Constraints for table `carousel`
--
ALTER TABLE `carousel`
  ADD CONSTRAINT `carousel_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `carousel_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

--
-- Constraints for table `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `offers_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`);

--
-- Constraints for table `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `rentals_ibfk_1` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`),
  ADD CONSTRAINT `rentals_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `rental_tools`
--
ALTER TABLE `rental_tools`
  ADD CONSTRAINT `rental_tools_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `rental_tools_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`tool_id`) REFERENCES `tools` (`id`);

--
-- Constraints for table `r_reviews`
--
ALTER TABLE `r_reviews`
  ADD CONSTRAINT `r_reviews_ibfk_1` FOREIGN KEY (`rtool_id`) REFERENCES `rental_tools` (`id`);

--
-- Constraints for table `tools`
--
ALTER TABLE `tools`
  ADD CONSTRAINT `tools_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `tools_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
