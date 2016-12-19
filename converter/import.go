package converter

import (
	"fmt"
	"time"
)

type Category struct {
	ID           int
	CategoryName string
}

type SellingItem struct {
	ID         int
	ProductID  string
	Quantity   int
	Revenue    int64
	NetRevenue float64
	OrderDate  time.Time
}

type Store struct {
	StoreID  int
	Name     string
	UserID   int
	Location string
}

type Product struct {
	ID          string
	ProductName string
	Price       int64
	Subcategory string
	Category    string
	StoreID     int
}

type User struct {
	ID        int
	Age       int
	Gender    int
	Location  string
	CreatedAt time.Time
}

type ProductAge struct {
	ID        int
	ProductID string
	Age       int
}

type OrderStatistic struct {
	ID         int
	StoreID    int
	OrderDate  time.Time
	Revenue    int64
	TotalOrder int
}

type UserStatistic struct {
	ID        int
	UserID    int
	OrderDate time.Time
	Spend     float64
}

type Video struct {
	VideoID        string
	Url            string
	Category       string
	Title          string
	Description    string
	ThumbnailImage string
	PublishedTime  time.Time
	ChannelId      string
	ChannelTitle   string
	ProductId      string
}

func Generate() {

	inCon, er := openConnection(actionExport)
	if er != nil {
		panic(er)
	}
	ouCon, er := openConnection(actionImport)
	if er != nil {
		panic(er)
	}

	// Import categories
	fmt.Println("Import categories")
	query := `SELECT DISTINCT category FROM product`
	var categories []string
	err := inCon.Raw(query).Pluck("category", &categories).Error
	if err != nil {
		panic(err)
	}

	for i := range categories {
		var cat Category
		cat.CategoryName = categories[i]
		err := ouCon.Create(&cat).Error
		if err != nil {
			panic(err)
		}
	}

	fmt.Println("Import products")
	// Import product
	query = `SELECT product_id as id, name as product_name, price, subcategory, category, store_id FROM product`
	var products []Product
	err = inCon.Raw(query).Find(&products).Error
	if err != nil {
		panic(err)
	}

	for _, product := range products {
		err := ouCon.Create(&product).Error
		if err != nil {
			panic(err)
		}
	}

	fmt.Println("Selling items")
	// Import selling items
	query = `SELECT order_date, product_id, SUM(quantity) AS quantity, SUM(revenue) AS revenue, Sum(revenue*(1-discount)) AS net_revenue
	FROM selling_order
	GROUP BY order_date, product_id
	ORDER BY order_date`
	var sellingItems []SellingItem
	err = inCon.Raw(query).Find(&sellingItems).Error
	if err != nil {
		panic(err)
	}

	for _, sellingItem := range sellingItems {
		err := ouCon.Create(&sellingItem).Error
		if err != nil {
			panic(err)
		}
	}

	//Import users
	fmt.Println("Import Users")
	query = `SELECT user_id as id, age, gender, creation_date as created_at, location FROM user`
	var users []User
	err = inCon.Raw(query).Find(&users).Error
	if err != nil {
		panic(err)
	}

	for _, user := range users {
		err := ouCon.Create(&user).Error
		if err != nil {
			panic(err)
		}
	}

	// Import product_ages
	fmt.Println("Import product_ages")
	query = "SELECT selling_order.product_id, `user`.age FROM selling_order JOIN `user` ON `user`.user_id = selling_order.customer_id"
	var productAges []ProductAge
	err = inCon.Raw(query).Find(&productAges).Error
	if err != nil {
		panic(err)
	}

	for _, productAge := range productAges {
		err := ouCon.Create(&productAge).Error
		if err != nil {
			panic(err)
		}
	}

	// Import order_statistics
	fmt.Println("Import order_statistics")
	query = `
		SELECT order_date, COUNT(order_id) as total_order,  product.store_id, sum(revenue) as revenue
	FROM selling_order
	JOIN product ON product.product_id = selling_order.product_id
	GROUP BY order_date, product.store_id
	ORDER BY order_date
		`
	var orderStatistics []OrderStatistic
	err = inCon.Raw(query).Find(&orderStatistics).Error
	if err != nil {
		panic(err)
	}

	for _, orderStatistic := range orderStatistics {
		err := ouCon.Create(&orderStatistic).Error
		if err != nil {
			panic(err)
		}
	}

	// Import user_statistics
	fmt.Println("Import user_statistics")
	query = `
SELECT order_date, customer_id as user_id, sum(revenue*(1-discount)) as spend
FROM selling_order 
GROUP BY order_date, customer_id
ORDER BY order_date
	`
	var userStatistics []UserStatistic
	err = inCon.Raw(query).Find(&userStatistics).Error
	if err != nil {
		panic(err)
	}

	for _, userStatistic := range userStatistics {
		err := ouCon.Create(&userStatistic).Error
		if err != nil {
			panic(err)
		}
	}

	// Import categories
	fmt.Println("Import categories")
	query = `SELECT * FROM video`
	var videos []Video
	err = inCon.Raw(query).Scan(&videos).Error
	if err != nil {
		panic(err)
	}

	for _, video := range videos {
		fmt.Println(video)
		err := ouCon.Save(&video).Error
		if err != nil {
			panic(err)
		}
	}

	inCon.Close()
	ouCon.Close()
}
