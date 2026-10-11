#!/bin/bash

# Update packages
dnf update -y

# Install Nginx
dnf install -y nginx

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Create webpage
cat > /usr/share/nginx/html/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ShopNova - Online Store</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #111827;
}

/* NAVBAR */
.navbar {
    background: #111827;
    color: white;
    padding: 18px 7%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 25px;
}

.logo {
    font-size: 26px;
    font-weight: bold;
}

.logo span {
    color: #38bdf8;
}

.search {
    flex: 1;
    max-width: 500px;
}

.search input {
    width: 100%;
    padding: 12px 18px;
    border-radius: 25px;
    border: none;
    outline: none;
    font-size: 15px;
}

.nav-links {
    display: flex;
    gap: 20px;
    align-items: center;
}

.nav-links a {
    color: white;
    text-decoration: none;
}

.cart {
    background: #38bdf8;
    color: #111827;
    padding: 10px 16px;
    border-radius: 20px;
    font-weight: bold;
    cursor: pointer;
}

/* HERO */
.hero {
    margin: 30px 7%;
    border-radius: 25px;
    padding: 70px 8%;
    background: linear-gradient(120deg, #0f172a, #2563eb);
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.hero-content {
    max-width: 600px;
}

.hero h1 {
    font-size: 50px;
    margin-bottom: 15px;
}

.hero p {
    font-size: 19px;
    color: #dbeafe;
    margin-bottom: 25px;
}

.shop-btn {
    background: white;
    color: #1d4ed8;
    padding: 14px 28px;
    border: none;
    border-radius: 30px;
    font-weight: bold;
    cursor: pointer;
}

/* CATEGORIES */
.categories {
    padding: 20px 7%;
}

.categories h2 {
    margin-bottom: 20px;
}

.category-buttons {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}

.category-buttons button {
    border: none;
    background: white;
    padding: 12px 22px;
    border-radius: 25px;
    cursor: pointer;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
}

.category-buttons button:hover {
    background: #2563eb;
    color: white;
}

/* PRODUCTS */
.products-section {
    padding: 35px 7%;
}

.products-section h2 {
    margin-bottom: 25px;
}

.products {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 25px;
}

.product {
    background: white;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.product:hover {
    transform: translateY(-6px);
}

.product-image {
    height: 220px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #eef2ff;
    font-size: 80px;
}

.product-info {
    padding: 18px;
}

.product-info h3 {
    margin-bottom: 8px;
}

.category {
    color: #6b7280;
    font-size: 14px;
}

.price {
    font-size: 20px;
    font-weight: bold;
    margin: 12px 0;
}

.add-btn {
    width: 100%;
    padding: 12px;
    background: #2563eb;
    color: white;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    font-weight: bold;
}

.add-btn:hover {
    background: #1d4ed8;
}

/* FEATURES */
.features {
    padding: 40px 7%;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
}

.feature {
    background: white;
    padding: 25px;
    border-radius: 15px;
    text-align: center;
}

.feature-icon {
    font-size: 35px;
    margin-bottom: 12px;
}

/* FOOTER */
footer {
    margin-top: 30px;
    padding: 35px 7%;
    background: #111827;
    color: white;
    text-align: center;
}

footer p {
    color: #9ca3af;
    margin-top: 10px;
}

/* CART */
.cart-panel {
    position: fixed;
    right: -400px;
    top: 0;
    width: 350px;
    height: 100%;
    background: white;
    box-shadow: -5px 0 20px rgba(0,0,0,0.2);
    padding: 25px;
    transition: 0.3s;
    z-index: 1000;
}

.cart-panel.active {
    right: 0;
}

.cart-panel h2 {
    margin-bottom: 20px;
}

.cart-item {
    padding: 12px 0;
    border-bottom: 1px solid #ddd;
}

.close-cart {
    float: right;
    cursor: pointer;
    font-size: 22px;
}

.checkout {
    margin-top: 25px;
    width: 100%;
    padding: 14px;
    background: #16a34a;
    color: white;
    border: none;
    border-radius: 10px;
    font-weight: bold;
}

/* MOBILE */
@media(max-width: 768px) {

    .navbar {
        flex-direction: column;
    }

    .search {
        width: 100%;
    }

    .hero {
        padding: 45px 25px;
    }

    .hero h1 {
        font-size: 36px;
    }

    .nav-links {
        flex-wrap: wrap;
        justify-content: center;
    }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">

    <div class="logo">
        Shop<span>Nova</span>
    </div>

    <div class="search">
        <input
            type="text"
            id="searchInput"
            placeholder="Search products..."
            onkeyup="searchProducts()">
    </div>

    <div class="nav-links">
        <a href="#">Home</a>
        <a href="#products">Products</a>

        <div class="cart" onclick="openCart()">
            🛒 Cart (<span id="cartCount">0</span>)
        </div>
    </div>

</nav>


<!-- HERO -->
<section class="hero">

    <div class="hero-content">

        <h1>Shop Smarter.<br>Live Better.</h1>

        <p>
            Discover premium products at amazing prices.
            Fast delivery, secure payments and great deals.
        </p>

        <button class="shop-btn"
                onclick="document.getElementById('products').scrollIntoView()">
            Shop Now →
        </button>

    </div>

</section>


<!-- CATEGORIES -->
<section class="categories">

    <h2>Shop by Category</h2>

    <div class="category-buttons">

        <button onclick="filterProducts('all')">
            All
        </button>

        <button onclick="filterProducts('electronics')">
            💻 Electronics
        </button>

        <button onclick="filterProducts('fashion')">
            👕 Fashion
        </button>

        <button onclick="filterProducts('home')">
            🏠 Home
        </button>

        <button onclick="filterProducts('sports')">
            ⚽ Sports
        </button>

    </div>

</section>


<!-- PRODUCTS -->
<section class="products-section" id="products">

    <h2>Featured Products</h2>

    <div class="products" id="productContainer">

        <div class="product" data-category="electronics"
             data-name="Wireless Headphones">

            <div class="product-image">
                🎧
            </div>

            <div class="product-info">

                <h3>Wireless Headphones</h3>

                <div class="category">
                    Electronics
                </div>

                <div class="price">
                    $79.99
                </div>

                <button class="add-btn"
                        onclick="addToCart('Wireless Headphones',79.99)">
                    Add to Cart
                </button>

            </div>

        </div>


        <div class="product" data-category="electronics"
             data-name="Smart Watch">

            <div class="product-image">
                ⌚
            </div>

            <div class="product-info">

                <h3>Smart Watch</h3>

                <div class="category">
                    Electronics
                </div>

                <div class="price">
                    $129.99
                </div>

                <button class="add-btn"
                        onclick="addToCart('Smart Watch',129.99)">
                    Add to Cart
                </button>

            </div>

        </div>


        <div class="product" data-category="fashion"
             data-name="Premium Sneakers">

            <div class="product-image">
                👟
            </div>

            <div class="product-info">

                <h3>Premium Sneakers</h3>

                <div class="category">
                    Fashion
                </div>

                <div class="price">
                    $89.99
                </div>

                <button class="add-btn"
                        onclick="addToCart('Premium Sneakers',89.99)">
                    Add to Cart
                </button>

            </div>

        </div>


        <div class="product" data-category="fashion"
             data-name="Classic Hoodie">

            <div class="product-image">
                🧥
            </div>

            <div class="product-info">

                <h3>Classic Hoodie</h3>

                <div class="category">
                    Fashion
                </div>

                <div class="price">
                    $49.99
                </div>

                <button class="add-btn"
                        onclick="addToCart('Classic Hoodie',49.99)">
                    Add to Cart
                </button>

            </div>

        </div>


        <div class="product" data-category="home"
             data-name="Modern Chair">

            <div class="product-image">
                🪑
            </div>

            <div class="product-info">

                <h3>Modern Chair</h3>

                <div class="category">
                    Home
                </div>

                <div class="price">
                    $159.99
                </div>

                <button class="add-btn"
                        onclick="addToCart('Modern Chair',159.99)">
                    Add to Cart
                </button>

            </div>

        </div>


        <div class="product" data-category="sports"
             data-name="Football">

            <div class="product-image">
                ⚽
            </div>

            <div class="product-info">

                <h3>Professional Football</h3>

                <div class="category">
                    Sports
                </div>

                <div class="price">
                    $29.99
                </div>

                <button class="add-btn"
                        onclick="addToCart('Professional Football',29.99)">
                    Add to Cart
                </button>

            </div>

        </div>

    </div>

</section>


<!-- FEATURES -->
<section class="features">

    <div class="feature">
        <div class="feature-icon">🚚</div>
        <h3>Fast Delivery</h3>
        <p>Quick and reliable delivery.</p>
    </div>

    <div class="feature">
        <div class="feature-icon">🔒</div>
        <h3>Secure Payment</h3>
        <p>Your transactions are protected.</p>
    </div>

    <div class="feature">
        <div class="feature-icon">↩️</div>
        <h3>Easy Returns</h3>
        <p>Simple and hassle-free returns.</p>
    </div>

    <div class="feature">
        <div class="feature-icon">💬</div>
        <h3>24/7 Support</h3>
        <p>We're always here to help.</p>
    </div>

</section>


<!-- FOOTER -->
<footer>

    <h2>ShopNova</h2>

    <p>
        Your trusted online shopping destination.
    </p>

    <p>
        © 2026 ShopNova. All rights reserved.
    </p>

</footer>


<!-- CART PANEL -->
<div class="cart-panel" id="cartPanel">

    <span class="close-cart" onclick="closeCart()">✕</span>

    <h2>Shopping Cart</h2>

    <div id="cartItems"></div>

    <h3>
        Total: $<span id="cartTotal">0.00</span>
    </h3>

    <button class="checkout">
        Proceed to Checkout
    </button>

</div>


<script>

let cart = [];


/* ADD TO CART */

function addToCart(name, price) {

    cart.push({
        name: name,
        price: price
    });

    updateCart();

}


/* UPDATE CART */

function updateCart() {

    document.getElementById("cartCount").innerText =
        cart.length;

    let container =
        document.getElementById("cartItems");

    container.innerHTML = "";

    let total = 0;

    cart.forEach((item, index) => {

        total += item.price;

        container.innerHTML += `
            <div class="cart-item">
                <strong>${item.name}</strong>
                <br>
                $${item.price.toFixed(2)}
                <button onclick="removeItem(${index})"
                        style="float:right;border:none;background:none;cursor:pointer">
                    ❌
                </button>
            </div>
        `;

    });

    document.getElementById("cartTotal").innerText =
        total.toFixed(2);

}


/* REMOVE ITEM */

function removeItem(index) {

    cart.splice(index, 1);

    updateCart();

}


/* OPEN CART */

function openCart() {

    document
        .getElementById("cartPanel")
        .classList.add("active");

}


/* CLOSE CART */

function closeCart() {

    document
        .getElementById("cartPanel")
        .classList.remove("active");

}


/* CATEGORY FILTER */

function filterProducts(category) {

    let products =
        document.querySelectorAll(".product");

    products.forEach(product => {

        if (
            category === "all" ||
            product.dataset.category === category
        ) {

            product.style.display = "block";

        } else {

            product.style.display = "none";

        }

    });

}


/* SEARCH */

function searchProducts() {

    let search =
        document
        .getElementById("searchInput")
        .value
        .toLowerCase();

    let products =
        document.querySelectorAll(".product");

    products.forEach(product => {

        let name =
            product.dataset.name.toLowerCase();

        if (name.includes(search)) {

            product.style.display = "block";

        } else {

            product.style.display = "none";

        }

    });

}

</script>

</body>
</html>
EOF

# Test Nginx configuration
nginx -t

# Restart Nginx
systemctl restart nginx

echo "Website deployment completed successfully!"