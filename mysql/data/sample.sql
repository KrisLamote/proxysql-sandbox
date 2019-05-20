CREATE TABLE `currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `currency` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `symbol` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currencies_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `currencies` (`id`, `currency`, `code`, `symbol`, `is_default`, `created_at`, `updated_at`)
VALUES
	(1,'United States Dollar','USD','$',0,NOW(),NOW()),
	(2,'Euro','EUR','€',1,NOW(),NOW()),
	(3,'Japanese Yen','JPY','¥',0,NOW(),NOW()),
	(4,'British Pound Sterling','GBP','£',0,NOW(),NOW()),
	(5,'Czech Republic Koruna','CZK','Kč',0,NOW(),NOW()),
	(6,'Denmark Krone','DKK','kr',0,NOW(),NOW()),
	(7,'Swiss Franc','CHF','CHF',0,NOW(),NOW()),
	(8,'Norway Krone','NOK','kr',0,NOW(),NOW()),
	(9,'Poland Zloty','PLN','zł',0,NOW(),NOW()),
	(10,'Russia Ruble','RUB','руб',0,NOW(),NOW()),
	(11,'Sweden Krona','SEK','kr',0,NOW(),NOW()),
	(12,'Turkey Lira','TRY','₺',0,NOW(),NOW()),
	(13,'Brazilian Real','BRL','R$',0,NOW(),NOW());
