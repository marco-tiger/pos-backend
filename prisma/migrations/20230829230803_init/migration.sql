-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `uid` VARCHAR(64) NOT NULL,
    `email` VARCHAR(64) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `google_id` VARCHAR(64) NOT NULL,
    `email_status` ENUM('DISABLED', 'UNVERIFIED', 'VERIFIED') NOT NULL DEFAULT 'DISABLED',
    `email_enabled` BOOLEAN NOT NULL DEFAULT false,
    `google_enabled` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `User_uid_key`(`uid`),
    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Business` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `business_name` VARCHAR(64) NOT NULL,
    `business_image` VARCHAR(255) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `email` VARCHAR(64) NOT NULL,
    `phone_number` VARCHAR(32) NOT NULL,
    `citizen_id` VARCHAR(32) NOT NULL,
    `tax_id` VARCHAR(32) NOT NULL,
    `user_id` INTEGER NOT NULL,

    UNIQUE INDEX `Business_user_id_key`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserConfiguration` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `open_at` VARCHAR(5) NOT NULL,
    `close_at` VARCHAR(5) NOT NULL,
    `service_fee_amount` DECIMAL(15, 2) NOT NULL,
    `service_fee_type` ENUM('PERCENTAGE', 'AMOUNT') NOT NULL,
    `tax_fee_amount` DECIMAL(15, 2) NOT NULL,
    `user_id` INTEGER NOT NULL,

    UNIQUE INDEX `UserConfiguration_user_id_key`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PaymentMethod` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `name` VARCHAR(32) NOT NULL,
    `icon` VARCHAR(255) NOT NULL,
    `provider` ENUM('MANUAL', 'MIDTRANS') NOT NULL,
    `user_configuration_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductCategory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `image` VARCHAR(255) NOT NULL,
    `color` VARCHAR(8) NOT NULL,
    `user_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Product` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `capital_price` DECIMAL(15, 2) NOT NULL,
    `sell_price` DECIMAL(15, 2) NOT NULL,
    `sold_count` INTEGER NOT NULL DEFAULT 0,
    `stock` INTEGER NOT NULL DEFAULT 0,
    `reserved_stock` INTEGER NOT NULL DEFAULT 0,
    `available_stock` INTEGER NOT NULL DEFAULT 0,
    `variant` VARCHAR(16) NOT NULL,
    `product_category_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductImage` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `url` VARCHAR(255) NOT NULL,
    `is_default` BOOLEAN NOT NULL DEFAULT false,
    `product_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductAddon` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `capital_price` DECIMAL(15, 2) NOT NULL,
    `sell_price` DECIMAL(15, 2) NOT NULL,
    `sold_count` INTEGER NOT NULL DEFAULT 0,
    `stock` INTEGER NOT NULL DEFAULT 0,
    `reserved_stock` INTEGER NOT NULL DEFAULT 0,
    `available_stock` INTEGER NOT NULL DEFAULT 0,
    `image` VARCHAR(255) NOT NULL,
    `user_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductStockHistory` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `type` ENUM('INCREASE', 'DECREASE') NOT NULL,
    `previous_stock` INTEGER NOT NULL,
    `current_stock` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `product_addon_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PointOfSale` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `transaction_id` VARCHAR(32) NOT NULL,
    `transactioin_number` VARCHAR(255) NOT NULL,
    `order_amount` DECIMAL(15, 2) NOT NULL,
    `discount_amount` DECIMAL(15, 2) NOT NULL,
    `discount_percentage` DECIMAL(15, 2) NOT NULL,
    `discount_type` ENUM('PERCENTAGE', 'AMOUNT') NOT NULL,
    `service_fee_amount` DECIMAL(15, 2) NOT NULL,
    `service_fee_percentage` DECIMAL(15, 2) NOT NULL,
    `service_fee_type` ENUM('PERCENTAGE', 'AMOUNT') NOT NULL,
    `tax_amount` DECIMAL(15, 2) NOT NULL,
    `tax_percentage` DECIMAL(15, 2) NOT NULL,
    `total_amount` DECIMAL(15, 2) NOT NULL,
    `notes` VARCHAR(64) NOT NULL,
    `shipping_address` VARCHAR(255) NOT NULL,
    `status` ENUM('OPEN', 'WAITING_PAYMENT', 'PAID', 'CANCEL') NOT NULL DEFAULT 'OPEN',
    `type` ENUM('DIRECT_AMOUNT', 'PRODUCT', 'PRODUCT_TABLE') NOT NULL,
    `payment_method` VARCHAR(32) NOT NULL,
    `user_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TransactionItem` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `product_price_amount` DECIMAL(15, 2) NOT NULL,
    `price_amount` DECIMAL(15, 2) NOT NULL,
    `discount_amount` DECIMAL(15, 2) NOT NULL,
    `discount_percentage` DECIMAL(15, 2) NOT NULL,
    `discount_type` ENUM('PERCENTAGE', 'AMOUNT') NOT NULL,
    `price_after_discount_amount` DECIMAL(15, 2) NOT NULL,
    `total_amount` DECIMAL(15, 2) NOT NULL,
    `notes` VARCHAR(64) NOT NULL,
    `product_id` INTEGER NOT NULL,
    `point_of_sale_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TransactionItemAddon` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `addon_price_amount` DECIMAL(15, 2) NOT NULL,
    `transaction_item_id` INTEGER NOT NULL,
    `product_addon_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `total_amount` DECIMAL(15, 2) NOT NULL,
    `payment_source` ENUM('MANUAL', 'MIDTRANS') NOT NULL,
    `point_of_sale_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ProductsWithAddons` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_ProductsWithAddons_AB_unique`(`A`, `B`),
    INDEX `_ProductsWithAddons_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Business` ADD CONSTRAINT `Business_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserConfiguration` ADD CONSTRAINT `UserConfiguration_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PaymentMethod` ADD CONSTRAINT `PaymentMethod_user_configuration_id_fkey` FOREIGN KEY (`user_configuration_id`) REFERENCES `UserConfiguration`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductCategory` ADD CONSTRAINT `ProductCategory_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Product` ADD CONSTRAINT `Product_product_category_id_fkey` FOREIGN KEY (`product_category_id`) REFERENCES `ProductCategory`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Product` ADD CONSTRAINT `Product_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductImage` ADD CONSTRAINT `ProductImage_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductAddon` ADD CONSTRAINT `ProductAddon_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductStockHistory` ADD CONSTRAINT `ProductStockHistory_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductStockHistory` ADD CONSTRAINT `ProductStockHistory_product_addon_id_fkey` FOREIGN KEY (`product_addon_id`) REFERENCES `ProductAddon`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PointOfSale` ADD CONSTRAINT `PointOfSale_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransactionItem` ADD CONSTRAINT `TransactionItem_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransactionItem` ADD CONSTRAINT `TransactionItem_point_of_sale_id_fkey` FOREIGN KEY (`point_of_sale_id`) REFERENCES `PointOfSale`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransactionItemAddon` ADD CONSTRAINT `TransactionItemAddon_transaction_item_id_fkey` FOREIGN KEY (`transaction_item_id`) REFERENCES `TransactionItem`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransactionItemAddon` ADD CONSTRAINT `TransactionItemAddon_product_addon_id_fkey` FOREIGN KEY (`product_addon_id`) REFERENCES `ProductAddon`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_point_of_sale_id_fkey` FOREIGN KEY (`point_of_sale_id`) REFERENCES `PointOfSale`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ProductsWithAddons` ADD CONSTRAINT `_ProductsWithAddons_A_fkey` FOREIGN KEY (`A`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ProductsWithAddons` ADD CONSTRAINT `_ProductsWithAddons_B_fkey` FOREIGN KEY (`B`) REFERENCES `ProductAddon`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
