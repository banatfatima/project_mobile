-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 03, 2024 at 12:25 PM
-- Server version: 10.5.20-MariaDB
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id21630622_flightdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  `passenger_name` varchar(255) NOT NULL,
  `number_of_adults` int(11) NOT NULL,
  `number_of_children` int(11) NOT NULL,
  `passenger_seat` varchar(10) DEFAULT NULL,
  `has_insurance` tinyint(1) NOT NULL,
  `selected_class` varchar(20) NOT NULL,
  `is_round_trip` tinyint(1) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `flight_id`, `passenger_name`, `number_of_adults`, `number_of_children`, `passenger_seat`, `has_insurance`, `selected_class`, `is_round_trip`, `price`, `created_at`) VALUES
(16, 123, 1, 'hhh', 2, 0, '0', 0, 'Economy', 1, 0, '2023-12-28 17:29:20'),
(17, 123, 1, 'Baria', 2, 0, '0', 0, 'First Class', 1, 0, '2023-12-28 17:29:44'),
(18, 123, 1, 'Fatima', 2, 0, '0', 0, 'First Class', 1, 0, '2023-12-28 17:30:20'),
(19, 123, 1, 'baria', 3, 0, NULL, 0, 'Economy', 1, 0, '2023-12-28 20:14:30'),
(20, 123, 1, 'baria', 3, 0, NULL, 0, 'Economy', 1, 0, '2023-12-28 20:14:30'),
(21, 123, 1, 'jjjj', 3, 0, NULL, 0, 'Economy', 1, 120, '2023-12-28 20:37:54'),
(22, 123, 1, 'Baria', 3, 0, '0', 0, 'Business', 1, 120, '2023-12-28 21:23:06'),
(23, 123, 1, 'roro', 3, 0, NULL, 0, 'Business', 1, 120, '2023-12-29 09:21:01');

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `id` int(11) NOT NULL,
  `flight_number` varchar(10) NOT NULL,
  `departure_airport` varchar(50) NOT NULL,
  `arrival_airport` varchar(50) NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  `available_seats` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`id`, `flight_number`, `departure_airport`, `arrival_airport`, `departure_time`, `arrival_time`, `available_seats`, `price`) VALUES
(1, 'ABC123', 'London', 'Beirut', '2023-01-01 12:00:00', '2023-01-01 15:00:00', 150, 120),
(2, 'XYZ789', 'Berlin', 'Beirut', '2023-01-02 10:00:00', '2023-01-02 13:00:00', 120, 90),
(3, 'SQ876', 'Beirut', 'Cairo', '2024-12-04 17:19:51', '2024-12-04 20:19:51', 150, 130),
(4, 'LH234', 'Dubai', 'Beirut', '2024-12-03 10:21:29', '2024-12-03 12:21:29', 150, 150),
(5, 'QF789', 'Istanbul', 'Beirut', '2024-12-06 14:28:07', '2024-12-06 16:28:07', 120, 200);

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `id` int(11) NOT NULL,
  `seatNumber` varchar(10) NOT NULL,
  `isOccupied` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `seats`
--

INSERT INTO `seats` (`id`, `seatNumber`, `isOccupied`) VALUES
(1, 'A1', 0),
(2, 'A2', 0),
(3, 'B1', 1),
(4, 'B2', 0),
(5, 'C1', 0),
(6, 'C2', 1),
(7, 'D1', 0),
(8, 'D2', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(2, 'asd', 'asd', '$2y$10$/Y8gzoCy2/N60S4CDcdNredVHxSNJK/IV07yCJf61RV/kSAPHeVNO'),
(3, 'fat', 'fat@gmail.com', '$2y$10$1ZGynAoRZj/eNJVinaFWVOBxuqxAPbLD83bWxtB5AZj1NmnmjKNYK'),
(8, 'fatima', 'ffatima@gmail.com', '$2y$10$ef1AN372sxofgFoHUb0U.OKTUS/NXjAPGhKuws11wa9M8DwgGy/LO'),
(14, '', '', '$2y$10$3COu8BErOT.EBGUosohoNuaCTepSK6nUwjCf72H2QjZznQpUh.JlK'),
(15, 'baria', 'baria@gmail.com', '$2y$10$Ua0Nq0pTDUO8PaI7n/9IWePRJXBzGGrx9MNtLjaCBlAPyFQU9Jos.'),
(16, '', '', '$2y$10$ka2f2AljmMH1Cb5g5Fn5QOx.z.IbYmhjslVCLwazUUIVYt7xXZKLi'),
(17, 'talia', 'talia@gmail.com', '$2y$10$xZhMrPlR5Us4NNIjmXLpKuF1zMWeRdaqxyZz5ZtdnZjWaMvDIkMSm'),
(18, 'Baria', 'Baria@gmail.com', '$2y$10$Ih8wggjRGTdJCWagjwTpMONCNeSReC.W.54XKpzH4wX6q56DmJGZu'),
(19, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$xWrGYQJyF5JKDwd1MCJ5NuFGy4Ggp7qELruyL60glFw2G31TIS806'),
(20, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$nhnKjIsEjz45HL0KtEDrteOfhdB8lP41Fb0DD7DWlZRd/xXFGCLky'),
(21, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$yM.M1c2T3PBCuZ95GLFrr.vvxtaHLfjRxx5iNv.ZokIbjlgQlHEDG'),
(22, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$9egzHpC1tWrhJxj3M23nPe7HTdVBEAB6lWubWq.fz3sKHqy3LE.EG'),
(23, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$HeOPJvkxS3AfOTFNm2BEBu4Vc0u5pAUqONSv/WpSg9QvefwyTO3pm'),
(24, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$wERYd.jElOlc8Ixi8Cx9Heigp.PZT04DUAW0xi1TPC1R7qsmwFN7m'),
(25, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$IG9Waw.wdq0QhX4pajwTmudL41vJye8NAkOnb4lXHJaOf/swCLo/2'),
(26, 'Roro Mikawi', 'Roro@gmail.com', '$2y$10$WFXAC7NxHM6sczStyi5UkeorIgx3lmHhnqeR/m4f5fgFJ6AiuhGYm'),
(27, '', '', '$2y$10$qzLL.fPh.MXVB9rU79h1l.w3jDe7cffjwowW0JTHore2wyYQwK4We'),
(28, '', '', '$2y$10$GJG6rora3cfOVOdoGUj5B.n9OAdfSZrHkFdIaT1rN.HlK2f4pW7AO'),
(29, 'Osaman Mikawi', 'Osman@gmail.com', '$2y$10$AUcyoKLtED2Fz3jAt/d./u8XdyflNkqP.dHYVnYn2hcwtaIQ3LDF6');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `flights`
--
ALTER TABLE `flights`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `seats`
--
ALTER TABLE `seats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
